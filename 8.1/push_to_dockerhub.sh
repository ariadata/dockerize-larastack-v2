#!/bin/bash

# exit when any command fails
set -e
PHP_VERSION=8.1

docker push ariadata/php-$PHP_VERSION:cli
docker push ariadata/php-$PHP_VERSION:fpm
docker push ariadata/php-$PHP_VERSION:fpm-nginx
docker push ariadata/php-$PHP_VERSION:supervisor
echo "\n🔥 Pushing to dockerhub is Done!"