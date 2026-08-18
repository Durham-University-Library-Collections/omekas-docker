#!/usr/bin/bash

# Abort the script at the first sign of failure.
set -e

# Set environment variables. Some will need overriding but software versions
# should be kept in step with docker development environment.
while read line || [[ -n $line ]]; do
    if [[ "$line" =~ ^# ]]; then
	continue
    fi
    if [[ "$line" =~ ^(.*)=(.*) ]]; then
	declare "${BASH_REMATCH[1]}"="${BASH_REMATCH[2]}"
    fi
done < ../.env

ENV_OMEKAS_BASE_PATH=./build

# Create the directory where we place the build
mkdir ${ENV_OMEKAS_BASE_PATH}

# Download the Omeka S CLI
curl -L https://github.com/GhentCDH/Omeka-S-Cli/releases/download/v${ENV_OMEKAS_CLI_VERSION}/omeka-s-cli.phar --output omeka-s-cli && \
    chmod +x omeka-s-cli

# Rest may need adjustment so that CLI can work out where to install!

# Use the CLI to download the core Omeka S application
rm -fr ${ENV_OMEKAS_BASE_PATH}/* && \
    ./omeka-s-cli core:download ${ENV_OMEKAS_BASE_PATH}/ ${ENV_OMEKAS_VERSION}

cd $ENV_OMEKAS_BASE_PATH

# Use the CLI to download the themes
../omeka-s-cli theme:download default:${ENV_THEME_Default_VERSION}
../omeka-s-cli theme:download freedom

# Download all modules defined in modules.json
# When url is null, the module is downloaded via the omeka-s-cli registry shorthand (Name:version).
# When url is set, the {version} placeholder is replaced and the full URL is passed to omeka-s-cli.
jq -r '.[] | "\(.name) \(.version) \(if .url == null then "null" else .url end)"' ../install/modules.json | \
    while read -r name version url; do \
        if [ "$url" = "null" ]; then \
            ../omeka-s-cli module:download "${name}:${version}"; \
        else \
            resolved_url=$(echo "$url" | sed "s/{version}/${version}/g"); \
            ../omeka-s-cli module:download "${resolved_url}"; \
        fi; \
    done

# Install our own themes and modules from source control
# May need authentication token
./omeka-s-cli module:download "gh:Durham-University-Library-Collections/omeka-s-HandAxeBlocks"

./omeka-s-cli theme:download "gh:Durham-University-Library-Collections/omekas-durham-theme"
