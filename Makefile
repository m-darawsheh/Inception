NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
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
	docker system prune -af

fclean: clean
	docker volume prune -f

re: fclean up

.PHONY: all up down start stop restart logs ps clean fclean re
