# ASPACE-DOCKER
builds an aspace dev environment with nyu plugins with docker-compose.

### Install
```shell
git clone https://github.com/nyudlts/aspace-dev-docker.git
cd aspace-dev-docker
git submodule update --init --recursive    ##  installs archivesspace and the nyu aspace plugins
cd archivesspace
git checkout tags/v2.7.0
git pull origin master
cd ../
make init
```
