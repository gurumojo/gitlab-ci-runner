.PHONY: build clean down launch logs ps purge report stop sweep tail test up

COUNT?=0

# DOCKERFILES?="-f docker-compose.vpn.yml"

build:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		build --force-rm ${SERVICE}

clean:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		down -v --remove-orphans --rmi local

down:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		down

launch:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		up -d --build --force-recreate --remove-orphans ${SERVICE}

logs:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		logs ${SERVICE}

ps:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		ps

purge: clean sweep

report:
	env

stop:
	docker-compose -f docker-compose.yml ${DOCKERFILES} stop ${SERVICE}

sweep:
	docker rm $(docker ps -aq) 2>/dev/null || true
	docker image prune -f

tail:
	docker-compose -f docker-compose.yml ${DOCKERFILES} \
		logs -f --tail ${COUNT} ${SERVICE}

test:
	exit 0

up:
	docker-compose -f docker-compose.yml ${DOCKERFILES} up -d ${SERVICE}
