# Durham setup
The durham-base-config branch modifies Maastricht's unattended-via-cli branch to install what we need for Durham's Omeka S installation. To
build this via Docker:
```
git clone -b durham-base-config git@github.com:Durham-University-Library-Collections/omekas-docker.git
cd omekas-docker
docker compose -p preinstall up -d
```

At Durham, the basic server set-up with Apache, PHP, etc. will be provisioned by Puppet. As the web servers have very restricted access to external
sources, the Omeka software, and any modules, vocabularies and resource templates will be gathered by a script running on the Jenkins build server.
(This script is yet to be written, but in the Docker environment these functions are provided by omeka-s/Dockerfile.

We have retained the targets omeka-runtime and omeka-debug which assemble the software **and** install it, but we have added a new target, omeka-preinstall,
which assembles the software only, and does not perform the install. The idea is that, pending the development of the Jenkins route, we can bring up this
docker image and then zip up the contents of /var/www on the server and transfer that to libweb01 or libweb01-test.

After assembling the software the installation step is needed, which ensures the Omeka S database is initialised and modules are activated. When running on
Docker you can use the following steps:
```
git clone -b durham-base-config git@github.com:Durham-University-Library-Collections/omekas-docker.git
cd omekas-docker
ENV_OMEKAS_TARGET=omeka-preinstall docker compose -p preinstall up -d
docker exec -it omekas bash
cd /
./install-omekas.sh
```

The idea is that the `install-omekas.sh` script will be transferred to libweb01 by Jenkins, along with the assembled software, and then executed to
effect the installation, or upgrade an existing installation after we have gone live. In the meantime, we can build the Docker target omeka-preinstall,
zip up the /var/www material, transfer that to libweb01 and use install-omeka.sh there to perform the installation.

## Tasks still to do:
- Remove modules we do not need
- Change the time zone (think it's Amsterdam)
- Remove vocabularies we do not need
- Work out how to fetch and install the Axeheads vocabulary
- Remove Maastricht resource templates we do not need
- Add the Axeheads resource tenplates
- Create a script to package up the files and script to transfer to libweb01
- Create the databases
- Deliver the database congiguration to the libweb01 server using Puppet
- Create a script to unpack the files and install in /var/www/collections.durham.ac.uk
- Consider any scripting for loading the Palaeostar data.
