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
	echo "cp -r $DEST/modules/$filename $BACKUP/modules/"
	checkStatus $? "Failed to back up module $filename"
        echo "$OSC module:disable $filename --base-path=$DEST"
	checkStatus $? "Failed to disable module $filename"
    fi
done

# Install or upgrade all modules defined in modules.json
jq -r '.[].name' $OPT/modules.json | \
    while read -r name; do
	if [[ -d "$DEST/modules/$name" ]]; then
	    echo "cp -r $DEST/modules/$name $BACKUP/modules/"
	    checkStatus $? "Failed to back up module $name"
	    echo "cp -r $SOURCE/build/modules/$name $DEST/modules/"
	    checkStatus $? "Failed to merge module $name"
	    echo "$OSC module:upgrade \"${name}\" --base-path $DEST"
	    checkStatus $? "Failed to upgrade module $name"
	else
	    echo "cp -r $SOURCE/build/modules/$name $DEST/modules/"
	    checkStatus $? "Failed to deploy module $name"
	    echo "$OSC module:install \"${name}\" --base-path $DEST"
	    checkStatus $? "Failed to install module $name"
	fi
    done

# Work through the rest of the build, backing up and installing
cd $SOURCE/build/
for filename in * .[^.]* ; do
    if [[ ! "$filename" =~ ^(config|files|logs|modules)$ ]]; then
	if [[ -e "$DEST/$filename" ]]; then
            echo "mv $DEST/$filename $BACKUP/$filename"
	    checkStatus $? "Failed to back up $filename"
	fi
        echo "mv $SOURCE/build/$filename $DEST/$filename"
	checkStatus $? "Failed to deploy $filename"
    fi
done

echo "Deployment script completed."
