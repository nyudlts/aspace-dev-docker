.DEFAULT_GOAL := help

help:  ## Print this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

start-mysql:	## start mysql server
	docker-compose up -d mysql

init:	## start mysql server
	docker-compose up -d mysql
	docker-compose exec mysql mysql -u root -p -e 'create database archivesspace default character set utf8;'
	docker-compose exec mysql mysql -u root -p -e "grant all on archivesspace.* to 'archivesspace'@'%' identified by 'archivesspace';"
	docker-compose up -d aspace
	docker-compose exec aspace /opt/archivesspace/build/run db:migrate
	docker-compose exec aspace /opt/archivesspace/build/run frontend:devserver


create-db:		## create aspace database
	docker-compose exec mysql mysql -u root -p -e 'create database archivesspace default character set utf8;'
	docker-compose exec mysql mysql -u root -p -e "grant all on archivesspace.* to 'archivesspace'@'%' identified by 'archivesspace';"

migrate-db:		## migrate the database
	docker-compose exec aspace /opt/archivesspace/build/run db:migrate

mysql-shell: 	## access mysql database
	docker-compose exec mysql mysql -u root -p

aspace-shell:	## access apsace container shell
	docker-compose exec aspace /bin/bash

nuke-db:	## access apsace container shell
	docker-compose exec aspace /opt/arcivesspace/build/run db:nuke

start-frontend:	## start aspace frontend
	docker-compose exec aspace /opt/archivesspace/build/run frontend:devserver

start-backend:	## start aspace backend and indexer
	docker-compose up -d aspace


stop-aspace:	## update the nyu plugins
	docker-compose down aspace

start-all:	## update the nyu plugins
	docker-compose up -d mysql
	docker-compose up -d aspace
	docker-compose exec aspace /opt/archivesspace/build/run frontend:devserver

