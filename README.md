# ASPACE-DOCKER
builds an aspace dev environment with nyu plugins.

1. $ git clone https://github.com/nyudlts/aspace-dev-docker.git
2. $ cd aspace-dev-docker
3. $ git submodule update --init --recursive    *##   installs the nyu aspace plugins*
4. $ make start-mysql
5. $ make create-db
6. $ make start-backend    *##   starts the backend and indexer* 
7. $ make-migrate-db		 *##	  runs database migrations, api should now be available at localhost:8089*
6. $ make start-frontend   *##   starts the frontend, should be available at localhost:8080*
