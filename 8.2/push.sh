#!/bin/bash

# exit when any command fails
set -e

docker push ariadata/php-8.2:cli

docker push ariadata/php-8.2:fpm

docker push ariadata/php-8.2:fpm-nginx

docker push ariadata/php-8.2:supervisor

echo "\n🔥 Pushing to dockerhub is Done!"