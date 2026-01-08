## Using the Omeka S Command Line interface
The Omeka S CLI is developed by the Ghent Center for Digital Humanities [see GitHub](https://github.com/GhentCDH/Omeka-S-Cli/)
and allows you to list, install/uninstall, enable/disable and upgrade Omeka S modules, resource templates, themes and vocabularies.

### Usage
1. Exec into the docker container
```bash
docker exec -it omekas bash
```

2. Run the CLI with the following example commands
```bash
omeka-s-cli module:list

omeka-s-cli module:disable BulkEdit

omeka-s-cli module:uninstall BulkEdit
```

### Full list of commands
The latest list of commands can be found in the CLI's [readme on GitHub](https://github.com/GhentCDH/Omeka-S-Cli/blob/main/README.md)
or by calling the help via:
```bash
omeka-s-cli -h
```


### Troubleshooting
The script tries to find the Omeka S base dir. If you get the following error:
```
Could not find a valid Omeka S context.
```
it could mean that you need to switch to the correct working directory, or provide the base path. Example:
```bash
# By switching directory
cd /var/www/html
omeka-s-cli module:list

# Or using the base path
omeka-s-cli module:list --base-path /var/www/html
```