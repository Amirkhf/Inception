NAME = inception
SRCS_DIR = srcs
COMPOSE = docker compose -f $(SRCS_DIR)/docker-compose.yml

all: up

up:
	@mkdir -p /home/amkhelif/data/mariadb
	@mkdir -p /home/amkhelif/data/wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

clean:
	$(COMPOSE) down -v

fclean: clean
	@docker system prune -a --volumes -f
	@sudo rm -rf /home/amkhelif/data/mariadb/*
	@sudo rm -rf /home/amkhelif/data/wordpress/*

re: fclean all

