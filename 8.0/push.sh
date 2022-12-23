#!/bin/bash

# exit when any command fails
set -e

docker push ariadata/php-8.0:cli

docker push ariadata/php-8.0:fpm

docker push ariadata/php-8.0:fpm-nginx

docker push ariadata/php-8.0:supervisor

echo "\n🔥 Pushing to dockerhub is Done!"