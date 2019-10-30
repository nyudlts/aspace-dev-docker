# ASPACE-DOCKER
builds an aspace dev environment with nyu plugins with docker-compose.

### Install
1. $ git clone https://github.com/nyudlts/aspace-dev-docker.git
2. $ cd aspace-dev-docker
3. $ git submodule update --init --recursive    *##   installs the nyu aspace plugins*
4. $ cd archivesspace
5. $ git checkout tags/v2.7.0
6. $ cd ../
7. $ make init
