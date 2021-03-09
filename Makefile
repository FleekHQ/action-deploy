build:
	docker build -t fleekhq/action-deploy .

run:
	docker run \
		-v $$(pwd):/github/workspace \
		--env-file .env \
		fleekhq/action-deploy
