#!/bin/bash

set -e
PHP_VERSION=8.4

echo "Start pushing ${PHP_VERSION}\n"
docker tag ariadata/php-$PHP_VERSION:cli ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:cli
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:cli
docker tag ariadata/php-$PHP_VERSION:fpm ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:fpm
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:fpm
docker tag ariadata/php-$PHP_VERSION:fpm-nginx ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:fpm-nginx
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:fpm-nginx
docker tag ariadata/php-$PHP_VERSION:supervisor ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:supervisor
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-$PHP_VERSION:supervisor
