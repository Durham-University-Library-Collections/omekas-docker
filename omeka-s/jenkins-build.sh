#!/usr/bin/bash

# Set environment variables. Some will need overriding but software versions
# should be kept in step with docker development environment.
source ../.env

curl -L https://github.com/GhentCDH/Omeka-S-Cli/releases/download/v${ENV_OMEKAS_CLI_VERSION}/omeka-s-cli.phar --output omeka-s-cli && \
    chmod +x omeka-s-cli
