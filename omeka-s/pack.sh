#!/usr/bin/bash

# Creates a tar file to transfer to our server for unpacking there.

TARFILE=/var/www/omeka.tar

# Add the Omeka application and any project files
cd /var/www
tar --exclude=html/volume --exclude=html/helper --exclude=html/logs --exclude=html/files --exclude html/config -cvf $TARFILE html projects
tar -rvf $TARFILE html/config/local.config.php

# Add the installation code which we need to run on the server
cd /
tar -rvf $TARFILE opt install-omekas.sh

# Place the packaged content somewhere we can access it from outside Docker.
mv $TARFILE /var/www/projects
