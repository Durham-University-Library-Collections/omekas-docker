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

# Install Omeka S core if not already installed
    if $OSC core:status --base-path ${OMEKAS_BASE_PATH} | grep -q "^installed"; then
        echo "Omeka S core is already installed. Skipping installation."
    else
        # install core
        echo "Installing Omeka S core ..."
        $OSC core:install \
            --admin-name "${OMEKAS_ADMIN_NAME:-admin}" \
            --admin-email "${OMEKAS_ADMIN_EMAIL:-admin@example.com}" \
            --admin-password "${OMEKAS_ADMIN_PASSWORD:-admin}" \
            --title "${OMEKAS_TITLE:-Omeka S}" \
            --time-zone "${OMEKAS_TIME_ZONE:-UTC}" \
            --locale "${OMEKAS_LOCALE:-en_US}" \
            --base-path ${OMEKAS_BASE_PATH:-/var/www/html}
    fi

# Note: Docker volume-binds are not available during build stage.
if [[ ! -d ${OMEKAS_BASE_PATH}/files/temp ]]
then
    mkdir ${OMEKAS_BASE_PATH}/files/temp
    chown www-data:www-data ${OMEKAS_BASE_PATH}/volume/files/temp
fi

# Unpack the initial ARK database
tar -xvf /tmp/init-arkandnoid-db.tar.gz -C ${OMEKAS_BASE_PATH}/files/

# Install modules
# TODO: Do this in a loop from reading a json or yaml file
# Modules that are dependencies for others must be installed first
$OSC module:install Common --base-path ${OMEKAS_BASE_PATH}
$OSC module:install Log --base-path ${OMEKAS_BASE_PATH}
# Then all other modules
$OSC module:install AdvancedSearch --base-path ${OMEKAS_BASE_PATH}
$OSC module:install SearchSolr --base-path ${OMEKAS_BASE_PATH}
$OSC module:install ArchiveRepertory --base-path ${OMEKAS_BASE_PATH}
$OSC module:install Ark --base-path ${OMEKAS_BASE_PATH}
$OSC module:install BlockPlus --base-path ${OMEKAS_BASE_PATH}
$OSC module:install BlocksDisposition --base-path ${OMEKAS_BASE_PATH}
$OSC module:install BulkEdit --base-path ${OMEKAS_BASE_PATH}
$OSC module:install BulkExport --base-path ${OMEKAS_BASE_PATH}
$OSC module:install CreateMissingThumbnails --base-path ${OMEKAS_BASE_PATH}
$OSC module:install CSVImport --base-path ${OMEKAS_BASE_PATH}
$OSC module:install CustomVocab --base-path ${OMEKAS_BASE_PATH}
$OSC module:install EasyAdmin --base-path ${OMEKAS_BASE_PATH}
$OSC module:install EUCookieBar --base-path ${OMEKAS_BASE_PATH}
$OSC module:install ExtractText --base-path ${OMEKAS_BASE_PATH}
$OSC module:install FileSideload --base-path ${OMEKAS_BASE_PATH}
$OSC module:install HideProperties --base-path ${OMEKAS_BASE_PATH}
$OSC module:install IiifSearch --base-path ${OMEKAS_BASE_PATH}
$OSC module:install IiifServer --base-path ${OMEKAS_BASE_PATH}
$OSC module:install ImageServer --base-path ${OMEKAS_BASE_PATH}
$OSC module:install Mirador --base-path ${OMEKAS_BASE_PATH}
$OSC module:install ModelViewer --base-path ${OMEKAS_BASE_PATH}
$OSC module:install NdeTermennetwerk --base-path ${OMEKAS_BASE_PATH}
$OSC module:install NumericDataTypes --base-path ${OMEKAS_BASE_PATH}
$OSC module:install PdfViewer --base-path ${OMEKAS_BASE_PATH}
$OSC module:install ResourceMeta --base-path ${OMEKAS_BASE_PATH}
$OSC module:install Sitemaps --base-path ${OMEKAS_BASE_PATH}
$OSC module:install Statistics --base-path ${OMEKAS_BASE_PATH}
$OSC module:install UniversalViewer --base-path ${OMEKAS_BASE_PATH}
$OSC module:install ValueSuggest --base-path ${OMEKAS_BASE_PATH}

# Create site
# TODO: create site via SQL import?

# Configure search page
# TODO: configure Advanced Search page and settings via SQL import?

# Load vocabularies
# TODO: load vocabularies via CLI

# Load resource templates
# TODO: load resource templates via CLI

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

