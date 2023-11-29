#!/bin/bash

# exit when any command fails
set -e

docker push ariadata/php-8.3:cli

docker push ariadata/php-8.3:fpm

docker push ariadata/php-8.3:fpm-nginx

docker push ariadata/php-8.3:supervisor

echo "\n🔥 Pushing to dockerhub is Done!"