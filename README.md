# ASPACE-DOCKER
builds an aspace dev environment with nyu plugins.

###Install
1. $ git clone https://github.com/nyudlts/aspace-dev-docker.git
2. $ cd aspace-dev-docker
3. $ git submodule update --init --recursive    *##   installs the nyu aspace plugins*
4. $ cd arcchivesspace
5. $ git checkout tags/v.2.7.0
6. $ cd ../
7. $ make init
