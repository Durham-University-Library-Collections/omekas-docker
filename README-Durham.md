# Durham setup
The durham-base-config branch modifies Maastricht's unattended-via-cli branch to install what we need for Durham's Omeka S installation. To
build this via Docker:
```
git clone -b durham-base-config git@github.com:Durham-University-Library-Collections/omekas-docker.git
cd omekas-docker
docker compose up -d
```
Optionally you can add the `-p` flag and a project name if you need to maintain several sets of images:
```
docker compose -p project_name up -d
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
effect the installation, or upgrade an existing installation after we have gone live.

In the meantime, we can build the Docker target omeka-preinstall, and use the pack.sh script to create a tar file of all the material to transfer that to libweb01, to use install-omekas.sh there to perform the installation. For example:
```
# Clone docker setup
git clone -b durham-base-config git@github.com:Durham-University-Library-Collections/omekas-docker.git
# Install theme
cd omekas-docker/externals
git clone -b change-to-palaeostar git@github.com:Durham-University-Library-Collections/omekas-durham-theme.git
cd ..
# build docker containers
ENV_OMEKAS_TARGET=omeka-preinstall docker compose -p preinstall up -d
docker exec -it omekas bash
cd /
./pack.sh
exit
cd projects
scp omeka.tar yourusername@libweb01-test.int.dur.ac.uk:/tmp/omeka.tar
ssh yourusername@libweb01-test.int.dur.ac.uk
sudo -iu httpd
omeka-install/unpack.sh
```
The above depends on /var/www/test.collections.durham.ac.uk/config/database.ini being present and correct, and an empty database (with no tables) having been created.

## Tasks still to do:
Not sure all need doing in this code, though, particularly the Palaeostar items.
- Remove modules we do not need
- Work out how to fetch and install the Axeheads vocabulary
- Add the Axeheads resource templates
- Consider any scripting for loading the Palaeostar data.
