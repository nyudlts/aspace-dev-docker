# ASPACE-DOCKER
builds an aspace dev environment with nyu plugins with docker-compose.

### Install
1. $ git clone https://github.com/nyudlts/aspace-dev-docker.git
2. $ cd aspace-dev-docker
3. $ git submodule update --init --recursive    ##  installs archivesspace and the nyu aspace plugins
4. $ git pull origin master
5. $ cd archivesspace
6. $ git checkout tags/v2.7.0
7. $ cd ../
8. $ make init
