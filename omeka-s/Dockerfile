ARG ENV_PHP_VERSION=8.2
FROM php:${ENV_PHP_VERSION}-fpm-bookworm AS php-builder

# Install development headers required for installing the PHP extensions
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libfreetype6-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    imagemagick \
    ghostscript

# Omeka S core and modules require additional PHP extensions
# As the PHP Docker image is kept as small as possible (see https://hub.docker.com/_/php), we need to install these extensions.
# The builtin helper script `docker-php-ext-install` can be used to compile extensions into PHP.
# The additional helper script 'docker-php-extension-installer' is even more convenient, as it simplifies the installation of PHP extensions by automatically adding and removing Debian (apt) and Alpine (apk) packages.
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && \
    install-php-extensions \
    # for Omeka S core
    gd \
    imagick \
    pdo \
    pdo_mysql \
    mysqli \
    xml \
    # for module Ark
    dba bcmath \
    # for module BulkExport
    zip \
    # for module NumericDataTypes
    intl



FROM php-builder AS php-debug
# Install extension for remote debugging in IDE (e.g. PhpStorm)
RUN install-php-extensions xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # Uncomment this to write xdebug logs to a file
#    && echo "xdebug.log = /tmp/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # Uncomment this one to start debugger on every request, regardless of the cookie set by the browser extension
#    && echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host = dockerhost.local" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini



FROM php:${ENV_PHP_VERSION}-fpm-bookworm AS os-builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # Common software
    apache2 \
    curl \
    nano \
    unzip \
    # to test database connectivity during entrypoint script
    default-mysql-client \
    # iproute2 is used to retrieve the IP of the docker host machine (needed for Xdebug connections)
    iproute2 \
    # runtime libraries (runtime equivalents) for the PHP extensions we compiled in the previous stage
    libfreetype6 \
    zlib1g \
    libpng16-16 \
    libjpeg62-turbo \
    libtiff6 \
    libavif15 \
    libzip4 \
    libxpm4 \
    imagemagick \
    ghostscript \
    # for (IIIF) image processing
    libvips-tools \
    # for module ExtractText
    poppler-utils \
    # for Omeka S module NumericDataTypes
    libicu-dev

# Some modules require composer
# In Docker it cannot be installed via apt because of unmet php dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Imagemagick config
# Thumbnails in Omeka S created by Imagemagick
# Processing PDF was disabled in ImageMagick config because of a vulnerability in GhostScript < 9.24 (see https://www.kb.cert.org/vuls/id/332928/)
# We're using GhostScript version 10.00.0 or higher, so we can safely re-enable the ImageMagick processing for PDF
RUN sed -i 's_<policy domain="coder" rights="none" pattern="PDF" />_<policy domain="coder" rights="read|write" pattern="PDF" />_g' /etc/ImageMagick-6/policy.xml

# PHP config
COPY php-config/99-omeka.ini $PHP_INI_DIR/conf.d/

# PHP-FPM config
RUN sed -i 's|error_log = /proc/self/fd/2|error_log = /var/log/php-fpm.log|g' /usr/local/etc/php-fpm.d/docker.conf && \
    sed -i 's|access.log = /proc/self/fd/2|access.log = /var/log/php-fpm.log|g' /usr/local/etc/php-fpm.d/docker.conf && \
    sed -i 's|listen = 9000|listen = /run/php-fpm.sock|g' /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'listen.owner = www-data' >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo 'listen.group = www-data' >> /usr/local/etc/php-fpm.d/zz-docker.conf

# Apache config
COPY apache-config/000-default.conf /etc/apache2/sites-available/

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN a2dismod mpm_prefork && \
    a2enmod mpm_event && \
    a2enmod proxy_fcgi && \
    a2enmod rewrite

# Enable http/2 to serve multiple files over the same tcp connection. This increases performance for IIIF image tiles.
RUN a2enmod http2

# Required to enable CORS for serving IIIF images to external clients.
RUN a2enmod headers



FROM os-builder AS omeka-runtime

# Copy compiled extensions and ini files from the php-builder stage
COPY --from=php-builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Add Omeka-S cli tool from GhentCDH
ARG ENV_OMEKAS_CLI_VERSION
RUN curl -L https://github.com/GhentCDH/Omeka-S-Cli/releases/download/v${ENV_OMEKAS_CLI_VERSION}/omeka-s-cli.phar --output /usr/local/bin/omeka-s-cli && \
    chmod +x /usr/local/bin/omeka-s-cli

# Install Omeka S core
ARG ENV_OMEKAS_BASE_PATH
ARG ENV_OMEKAS_VERSION
RUN rm -fr ${ENV_OMEKAS_BASE_PATH}/* && \
    omeka-s-cli core:download ${ENV_OMEKAS_BASE_PATH}/ ${ENV_OMEKAS_VERSION}

# Put files/ folder in data volume and symlink to it from Omeka S folder
RUN mkdir -p ${ENV_OMEKAS_BASE_PATH}/volume/files/ && \
    rm -Rf ${ENV_OMEKAS_BASE_PATH}/files/ && \
    ln -s ${ENV_OMEKAS_BASE_PATH}/volume/files/ ${ENV_OMEKAS_BASE_PATH}/files
VOLUME ${ENV_OMEKAS_BASE_PATH}/volume/

# Precreate the IIIF manifest cache folders
RUN mkdir -p ${ENV_OMEKAS_BASE_PATH}/files/iiif/2 && \
    mkdir -p ${ENV_OMEKAS_BASE_PATH}/files/iiif/3

# Install modules
# TODO: Do this in a loop from reading a json or yaml file
ARG ENV_MODULE_AdvancedSearch_VERSION
RUN omeka-s-cli module:download AdvancedSearch:${ENV_MODULE_AdvancedSearch_VERSION}

ARG ENV_MODULE_SearchSolr_VERSION
RUN omeka-s-cli module:download https://github.com/Daniel-KM/Omeka-S-module-SearchSolr/releases/download/${ENV_MODULE_SearchSolr_VERSION}/SearchSolr-${ENV_MODULE_SearchSolr_VERSION}.zip

ARG ENV_MODULE_ArchiveRepertory_VERSION
RUN omeka-s-cli module:download ArchiveRepertory:${ENV_MODULE_ArchiveRepertory_VERSION}

ARG ENV_MODULE_Ark_VERSION
RUN omeka-s-cli module:download Ark:${ENV_MODULE_Ark_VERSION}

ARG ENV_MODULE_BlockPlus_VERSION
RUN omeka-s-cli module:download BlockPlus:${ENV_MODULE_BlockPlus_VERSION}

ARG ENV_MODULE_BlocksDisposition_VERSION
RUN omeka-s-cli module:download BlocksDisposition:${ENV_MODULE_BlocksDisposition_VERSION}

ARG ENV_MODULE_BulkEdit_VERSION
RUN omeka-s-cli module:download BulkEdit:${ENV_MODULE_BulkEdit_VERSION}

ARG ENV_MODULE_BulkExport_VERSION
RUN omeka-s-cli module:download BulkExport:${ENV_MODULE_BulkExport_VERSION}

ARG ENV_MODULE_Common_VERSION
RUN omeka-s-cli module:download Common:${ENV_MODULE_Common_VERSION}

ARG ENV_MODULE_CreateMissingThumbnails_VERSION
RUN omeka-s-cli module:download CreateMissingThumbnails:${ENV_MODULE_CreateMissingThumbnails_VERSION}

ARG ENV_MODULE_CSVImport_VERSION
RUN omeka-s-cli module:download CSVImport:${ENV_MODULE_CSVImport_VERSION}

ARG ENV_MODULE_CustomVocab_VERSION
RUN omeka-s-cli module:download CustomVocab:${ENV_MODULE_CustomVocab_VERSION}

ARG ENV_MODULE_EasyAdmin_VERSION
RUN omeka-s-cli module:download EasyAdmin:${ENV_MODULE_EasyAdmin_VERSION}

ARG ENV_MODULE_EUCookieBar_VERSION
RUN omeka-s-cli module:download EUCookieBar:${ENV_MODULE_EUCookieBar_VERSION}

ARG ENV_MODULE_ExtractText_VERSION
RUN omeka-s-cli module:download ExtractText:${ENV_MODULE_ExtractText_VERSION}

ARG ENV_MODULE_FileSideload_VERSION
RUN omeka-s-cli module:download FileSideload:${ENV_MODULE_FileSideload_VERSION}

ARG ENV_MODULE_HideProperties_VERSION
RUN omeka-s-cli module:download HideProperties:${ENV_MODULE_HideProperties_VERSION}

ARG ENV_MODULE_IiifSearch_VERSION
RUN omeka-s-cli module:download https://github.com/smachefert/Omeka-S-module-IiifSearch/archive/refs/tags/v${ENV_MODULE_IiifSearch_VERSION}.zip

ARG ENV_MODULE_IiifServer_VERSION
RUN omeka-s-cli module:download IiifServer:${ENV_MODULE_IiifServer_VERSION}

ARG ENV_MODULE_ImageServer_VERSION
RUN omeka-s-cli module:download ImageServer:${ENV_MODULE_ImageServer_VERSION}

ARG ENV_MODULE_Log_VERSION
RUN omeka-s-cli module:download Log:${ENV_MODULE_Log_VERSION}

ARG ENV_MODULE_Mirador_VERSION
RUN omeka-s-cli module:download https://github.com/Daniel-KM/Omeka-S-module-Mirador/releases/download/${ENV_MODULE_Mirador_VERSION}/Mirador-${ENV_MODULE_Mirador_VERSION}.zip

ARG ENV_MODULE_ModelViewer_VERSION
RUN omeka-s-cli module:download https://gitlab.com/mcoonen/Omeka-S-module-ModelViewer/-/archive/${ENV_MODULE_ModelViewer_VERSION}/Omeka-S-module-ModelViewer-${ENV_MODULE_ModelViewer_VERSION}.zip

ARG ENV_MODULE_NdeTermennetwerk_VERSION
RUN omeka-s-cli module:download NdeTermennetwerk:${ENV_MODULE_NdeTermennetwerk_VERSION}

ARG ENV_MODULE_NumericDataTypes_VERSION
RUN omeka-s-cli module:download NumericDataTypes:${ENV_MODULE_NumericDataTypes_VERSION}

ARG ENV_MODULE_PdfViewer_VERSION
RUN omeka-s-cli module:download https://github.com/Daniel-KM/Omeka-S-module-PdfViewer/archive/refs/tags/${ENV_MODULE_PdfViewer_VERSION}.zip

ARG ENV_MODULE_ResourceMeta_VERSION
RUN omeka-s-cli module:download ResourceMeta:${ENV_MODULE_ResourceMeta_VERSION}

ARG ENV_MODULE_Sitemaps_VERSION
RUN omeka-s-cli module:download Sitemaps:${ENV_MODULE_Sitemaps_VERSION}

ARG ENV_MODULE_Statistics_VERSION
RUN omeka-s-cli module:download Statistics:${ENV_MODULE_Statistics_VERSION}

ARG ENV_MODULE_UniversalViewer_VERSION
RUN omeka-s-cli module:download UniversalViewer:${ENV_MODULE_UniversalViewer_VERSION}

ARG ENV_MODULE_ValueSuggest_VERSION
RUN omeka-s-cli module:download ValueSuggest:${ENV_MODULE_ValueSuggest_VERSION}

# Install the default theme
# Our own themes will be volume-binded in docker-compose.yml
ARG ENV_THEME_Default_VERSION
RUN omeka-s-cli theme:download default:${ENV_THEME_Default_VERSION}
RUN omeka-s-cli theme:download freedom

# Copy other files and folders into the container
COPY config/ ${ENV_OMEKAS_BASE_PATH}/config/
COPY .htaccess ${ENV_OMEKAS_BASE_PATH}/.htaccess
COPY init-arkandnoid-db.tar.gz /tmp/
COPY docker-entrypoint.sh /

# Set correct ownership on www folders
RUN chown -R www-data:www-data ${ENV_OMEKAS_BASE_PATH}/

# Expose ports to Docker network
# Port 9000 remains exposed by the upstream image, but is not used here as we're connecting to PHP-FPM over an unix socket instead of TCP/IP
EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]



FROM omeka-runtime AS omeka-debug
# Copy compiled extensions and ini files from the php-debug stage
COPY --from=php-debug /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-debug /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

