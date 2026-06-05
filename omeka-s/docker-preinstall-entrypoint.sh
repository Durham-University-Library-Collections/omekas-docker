#!/bin/bash

OSC="omeka-s-cli"

# -----------------------------------------------------
# Xdebug configuration
# -----------------------------------------------------

# Add an /etc/hosts entry for the IP of the Docker host machine (required for Xdebug connections to PhpStorm on the host)
echo "$(ip route|awk '/default/ { print $3 }') dockerhost.local" >> /etc/hosts


# -----------------------------------------------------
# Omeka operations that need to happen during runtime
# -----------------------------------------------------

# Generate database configuration file
echo "Creating database.ini in ${OMEKAS_BASE_PATH}/config/ ..."
rm -f /var/www/html/config/database.ini
echo "user     = \"$MYSQL_USER\"" > ${OMEKAS_BASE_PATH}/config/database.ini
echo "password = \"$MYSQL_PASSWORD\"" >> ${OMEKAS_BASE_PATH}/config/database.ini
echo "dbname   = \"$MYSQL_DATABASE\"" >> ${OMEKAS_BASE_PATH}/config/database.ini
echo "host     = \"$MYSQL_HOST\"" >> ${OMEKAS_BASE_PATH}/config/database.ini
echo "Done creating database.ini !"

wait_for_db() {
    echo "Waiting for database to be ready..."
    local max_attempts=30
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        if mysql -h"${MYSQL_HOST:-db}" -P"${MYSQL_PORT:-3306}" -u"${MYSQL_USER:-omekas}" -p"${MYSQL_PASSWORD:-difficult_omek4s_password}" -e "SELECT 1;" >/dev/null 2>&1; then
            echo "Database is ready!"
            return 0
        fi
        echo "Database not ready, attempt $attempt/$max_attempts. Waiting 5 seconds..."
        sleep 5
        attempt=$((attempt + 1))
    done

    echo "ERROR: Database failed to become ready after $max_attempts attempts"
    exit 1
}
wait_for_db

# Note: Docker volume-binds are not available during build stage.
if [[ ! -d ${OMEKAS_BASE_PATH}/files/temp ]]
then
    mkdir ${OMEKAS_BASE_PATH}/files/temp
    chown www-data:www-data ${OMEKAS_BASE_PATH}/volume/files/temp
fi

# -----------------------------------------------------
# Apache and PHP-FPM startup
# -----------------------------------------------------
service apache2 start
php-fpm -D

# End with a persistent foreground process
tail -F ${OMEKAS_BASE_PATH}/logs/application.log \
        ${OMEKAS_BASE_PATH}/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log \
        /var/log/php-fpm.log

