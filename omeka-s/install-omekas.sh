#!/bin/bash

if [[ "$ENV_OMEKAS_ENV" = "prod" ]]; then
    OSC="/home/fake/httpd/omeka-install/omeka-s-cli"
    OPT="/home/fake/httpd/omeka-install/opt"
else
    OSC="omeka-s-cli"
    OPT="/opt"
fi

# -----------------------------------------------------
# Omeka operations that need to happen during runtime
# -----------------------------------------------------

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

# Install all modules defined in modules.json
jq -r '.[].name' $OPT/modules.json | \
    while read -r name; do
        $OSC module:install "${name}" --base-path ${OMEKAS_BASE_PATH}
    done

# Create site
# TODO: create site via SQL import?

# Configure search page
# TODO: configure Advanced Search page and settings via SQL import?

# Download and import vocabularies defined in vocabularies.json
# This will not work on libweb server: will need to download first.
jq -r '.[] | [.label, .version, .url, .namespaceUri, .prefix] | @tsv' $OPT/vocabularies.json | \
  while IFS=$'\t' read -r label version url namespaceUri prefix; do
      resolved_url=$(echo "$url" | sed "s/{version}/${version}/g")
      $OSC vocabulary:import \
          --url "$resolved_url" \
          --namespace-uri "$namespaceUri" \
          --prefix "$prefix" \
          --label "$label - $version" \
          --format=rdfxml \
          --base-path "$OMEKAS_BASE_PATH"
  done

# TODO: Import custom vocabularies
# e.g. omeka-s-cli custom-vocabulary:import custom_vocab_terms.json 3 (or 4, 5, 6)

# Download and import resource templates defined in resource-templates.json
# This will not work on libweb server: will need to download first.
mkdir -p /tmp/resource-templates/
jq -r '.[] | [.name, .version, .url] | @tsv' $OPT/resource-templates.json | \
    while IFS=$'\t' read -r name version url; do
        resolved_url=$(echo "$url" | sed "s/{version}/${version}/g" | sed "s/{name}/${name}/g")
        curl -L ${resolved_url} --output /tmp/resource-templates/${name}.json
        $OSC resource-template:import \
            "/tmp/resource-templates/${name}.json" \
            --base-path ${OMEKAS_BASE_PATH}
    done
