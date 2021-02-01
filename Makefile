install: docker-down-clear docker-pull docker-build docker-up install-yii2

init: docker-down-clear docker-pull docker-build docker-up composer-install

docker-up:
	docker-compose up -d

docker-down-clear:
	docker-compose down --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

composer-install:
	docker-compose run --rm project composer install

install-yii2:
	docker-compose run --rm install composer create-project --prefer-dist yiisoft/yii2-app-basic project