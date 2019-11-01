.DEFAULT_GOAL := help

help:  ## Print this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

start-mysql:	## start mysql server
	docker-compose up -d mysql

init:	## start mysql server
	docker-compose up -d mysql
	## Test condition from https://stackoverflow.com/questions/25503412/how-do-i-know-when-my-docker-mysql-container-is-up-and-mysql-is-ready-for-taking (answer by Matt Kramer)
	until docker container exec aspace-dev-docker_mysql_1 mysql --user=root --password=password -e "SELECT 1" >/dev/null 2>&1; do : ; done
	docker-compose exec mysql mysql -u root -ppassword -e 'create database archivesspace default character set utf8;'
	docker-compose exec mysql mysql -u root -ppassword -e "grant all on archivesspace.* to 'archivesspace'@'%' identified by 'archivesspace';"
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

nuke:	## access apsace container shell
	docker-compose down
	docker system prune -a
	docker volume prune

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

