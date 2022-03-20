build.dev:
	cp ./docker/config/env/dev.env ./.env && docker-compose build
run.dev:
	cp ./docker/config/env/dev.env ./.env && docker-compose up -d

build.staging:
	cp ./docker/config/env/staging.env ./.env && docker-compose build
run.staging:
	cp ./docker/config/env/staging.env ./.env && docker-compose up -d