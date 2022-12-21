.DEFAULT_GOAL := up

.PHONY: up
up:
	docker compose -f dev.compose.yaml down --remove-orphans
	docker compose -f dev.compose.yaml up --build

.PHONY: test
test:
	docker compose -f test.compose.yaml down --remove-orphans
	docker compose -f test.compose.yaml up -d database

	docker compose -f test.compose.yaml build app
	docker compose -f test.compose.yaml run app mix test
	docker compose -f test.compose.yaml down --remove-orphans
