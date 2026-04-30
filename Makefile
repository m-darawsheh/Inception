NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_PATH = /home/${USER}/data

DB_DATA = ${DATA_PATH}/db
WP_DATA = ${DATA_PATH}/wp

all: up

up:
	@mkdir -p ${DB_DATA}
	@mkdir -p ${WP_DATA}
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart: down up

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean: down
	docker system prune -f

fclean: clean
	docker volume prune -f
	sudo chown -R ${USER}:${USER} ${DATA_PATH} 2>/dev/null || true
	rm -rf ${DATA_PATH}

re: fclean up

.PHONY: all up down start stop restart logs ps clean fclean re
