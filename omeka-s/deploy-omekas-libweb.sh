#!/bin/bash

function checkStatus {
    if [ "$1" -ne 0 ]; then
        echo "$2";
	# Try to ensure we break out of jq pipes if one stage fails: not tested
	set -e
	set -o pipefail
        exit "$1";
    fi
}

function dbConfig {
    if [[ ! -f "${DEST}/config/database.ini" ]]; then
	echo "Could not find database.ini in ${DEST}/config"
	exit 1
    fi

    match=$(grep "^$1" $DEST/config/database.ini)
    if [[ "$match" =~ \"(.*)\" ]]; then
	echo "${BASH_REMATCH[1]}"
    fi
}

function deployModule {
    if [[ -d "$DEST/modules/$1" ]]; then
	cp -r "$DEST/modules/$1" "$BACKUP/modules/"
	checkStatus $? "Failed to back up module $1"
	cp -rf "$SOURCE/build/modules/$1" "$DEST/modules/"
	checkStatus $? "Failed to merge module $1"
	$OSC module:upgrade "$1" --base-path="$DEST"
	checkStatus $? "Failed to upgrade module $1"
    else
	cp -rf "$SOURCE/build/modules/$1" "$DEST/modules/"
	checkStatus $? "Failed to deploy module $1"
	$OSC module:install "$1" --base-path="$DEST"
	checkStatus $? "Failed to install module $1"
    fi
}

# Check parameters provided                                                     
if [ $# -ne 3 ]
then
    echo "Incorrect number of parameters supplied"
    exit 1
fi

# Temporary directory containing new build
SOURCE=$1

# Destination directory: Omeka base path
DEST=$2

# Backup directory
BACKUP=$3

if [ ! -d $SOURCE ]; then
    echo "Source directory $SOURCE not found"
    exit 1
fi

if [ ! -d $DEST ]; then
    echo "Destination directory $DEST not found"
    exit 1
fi

if [ ! -d $BACKUP ]; then
    echo "Backup directory $BACKUP not found"
    exit 1
fi

OSC="$SOURCE/omeka-s-cli"
OPT="$SOURCE/install"

# -----------------------------------------------------
# Omeka operations that need to happen during runtime
# -----------------------------------------------------

# -----------------------------------------------------
# Copy files into location
# -----------------------------------------------------

# Set globbing behaviour
is_nullglob=$( shopt -s | egrep -i '.*nullglob' )
is_dotglob=$( shopt -s | egrep -i '.*dotglob' )
shopt -s nullglob
shopt -s dotglob

# Work through the rest of the build, backing up and installing
cd $SOURCE/build/
for filename in *; do
    if [[ ! "$filename" =~ ^(config|files|logs|modules)$ ]]; then
	if [[ -e "$DEST/$filename" ]]; then
            mv "$DEST/$filename" "$BACKUP/$filename"
	    checkStatus $? "Failed to back up $filename"
	fi
        mv "$SOURCE/build/$filename" "$DEST/$filename"
	checkStatus $? "Failed to deploy $filename"
    fi
done

# For config, files and logs only copy what does not already exist
for dir in *; do
    if [[ "$dir" =~ ^(config|files|logs)$ ]]; then
	for filename in $dir/*; do
	    if [[ ! -e "$DEST/$filename" ]]; then
		mv "$SOURCE/build/$filename" "$DEST/$filename"
		checkStatus $? "Failed to deploy $filename"
	    fi
	done
    fi
done

# Restore previous settings
[[ $is_nullglob ]] || shopt -u nullglob
[[ $is_dotglob ]] || shopt -u dotglob

# -----------------------------------------------------
# Install Omeka S core if not already installed
# -----------------------------------------------------

mkdir -p "$DEST/modules/"

if $OSC core:status --base-path ${DEST} | grep -q "^installed"; then
    echo "Omeka S core is already installed. Skipping installation."
else
    # install core
    echo "Ensuring database exists..."
    user=$(dbConfig user)
    password=$(dbConfig password)
    dbname=$(dbConfig dbname)
    host=$(dbConfig host)
    MYSQL_PWD="${password}" mysql -u ${user} -h ${host} -e "CREATE DATABASE IF NOT EXISTS ${dbname} CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_520_ci'"

    echo "Installing Omeka S core ..."
    source /var/www/settings/omeka
    $OSC core:install \
	 --admin-name "${OMEKAS_ADMIN_NAME:-admin}" \
         --admin-email "${OMEKAS_ADMIN_EMAIL:-admin@example.com}" \
         --admin-password "${OMEKAS_ADMIN_PASSWORD:-admin}" \
         --title "${OMEKAS_TITLE:-Omeka S}" \
         --time-zone "${OMEKAS_TIME_ZONE:-UTC}" \
         --locale "${OMEKAS_LOCALE:-en_US}" \
         --base-path ${DEST}
    checkStatus $? "Failed to install Omeka S core"
fi

# -----------------------------------------------------
# Install, upgrade or disable modules
# -----------------------------------------------------

mkdir -p "$BACKUP/modules"

# Work through the current modules and disable any which have been removed
cd $DEST/modules/
for filename in * ; do
    if [[ ! -d "$filename" ]]; then
        # Skip anything which is not a directory
        continue
    fi
    if [[ ! -d "$SOURCE/build/modules/$filename" ]]; then
	cp -r "$DEST/modules/$filename" "$BACKUP/modules/"
	checkStatus $? "Failed to back up module $filename"
        result=$($OSC module:disable $filename --base-path="$DEST" 2>&1)
	if [[ "$result" =~ 'is marked as "not_installed" and cannot be deactivated' ]]; then
	    echo "$filename already uninstalled"
	elif [[ "$result" =~ 'is already disabled' ]]; then
	    echo $result
	else
	    echo $result
	    exit 1
	fi
    fi
done

# Install or upgrade all modules defined in modules.json

# First tackle upgrades by backing up and copying in new files
jq -r '.[].name' $OPT/modules.json | \
    while read -r name; do
	if [[ -d "$DEST/modules/$name" ]]; then
	    cp -r "$DEST/modules/$name" "$BACKUP/modules/"
	    checkStatus $? "Failed to back up module $name"
	    cp -rf "$SOURCE/build/modules/$name" "$DEST/modules/"
	    checkStatus $? "Failed to merge module $name"
	fi
    done

# We postpone the actual upgrade until all new files are in place: needed
# for some dependencies like AdvancedSearch and SearchSolr
jq -r '.[].name' $OPT/modules.json | \
    while read -r name; do
	if [[ -d "$DEST/modules/$name" ]]; then
	    $OSC module:upgrade "$name" --base-path="$DEST"
	    checkStatus $? "Failed to upgrade module $name"
	fi
    done

# Then install any new modules
jq -r '.[].name' $OPT/modules.json | \
    while read -r name; do
	if [[ ! -d "$DEST/modules/$name" ]]; then
	    cp -rf "$SOURCE/build/modules/$name" "$DEST/modules/"
	    checkStatus $? "Failed to deploy module $name"
	    $OSC module:install "$name" --base-path="$DEST"
	    checkStatus $? "Failed to install module $name"
	fi
    done

# Install or upgrade our own modules
deployModule HandAxeBlocks

# -----------------------------------------------------
# Finished
# -----------------------------------------------------

# FIXME: Should remove $SOURCE here, but need to be sure all errors up to
# this point will have stopped the script.

echo "Deployment script completed."
