#!/bin/bash

function checkStatus {
    if [ "$1" -ne 0 ]; then
        echo "$2";
        exit "$1";
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
        $OSC module:disable $filename --base-path="$DEST"
	checkStatus $? "Failed to disable module $filename"
    fi
done

# Install or upgrade all modules defined in modules.json
jq -r '.[].name' $OPT/modules.json | \
    while read -r name; do
	if [[ -d "$DEST/modules/$name" ]]; then
	    cp -r "$DEST/modules/$name" "$BACKUP/modules/"
	    checkStatus $? "Failed to back up module $name"
	    cp -rf "$SOURCE/build/modules/$name" "$DEST/modules/"
	    checkStatus $? "Failed to merge module $name"
	    $OSC module:upgrade "${name}" --base-path="$DEST"
	    checkStatus $? "Failed to upgrade module $name"
	else
	    cp -rf "$SOURCE/build/modules/$name" "$DEST/modules/"
	    checkStatus $? "Failed to deploy module $name"
	    $OSC module:install "${name}" --base-path="$DEST"
	    checkStatus $? "Failed to install module $name"
	fi
    done

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

# Restore previous settings
[[ $is_nullglob ]] || shopt -u nullglob
[[ $is_dotglob ]] || shopt -u dotglob

echo "Deployment script completed."
