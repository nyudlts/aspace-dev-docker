.DEFAULT_GOAL := help

help:  ## Print this help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

start-mysql:	## start mysql server
	docker-compose up -d mysql

create-db:	##	create aspace database
	docker-compose exec mysql mysql -u root -p -e 'create database archivesspace default character set utf8;'
	docker-compose exec mysql mysql -u root -p -e "grant all on archivesspace.* to 'archivesspace'@'%' identified by 'archivesspace';"

mysql-shell: 	## access mysql database
	docker-compose exec mysql mysql -u root -p

aspace-shell:	## access apsace container shell
	docker-compose exec aspace /bin/bash

start-frontend:	## start aspace frontend
	docker-compose exec aspace /opt/archivesspace/build/run frontend:devserver

start-backend:	## start aspace backend and indexer
	docker-compose up