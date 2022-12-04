#!/bin/bash

# exit when any command fails
set -e

docker push ariadata/php-8.1:cli

docker push ariadata/php-8.1:fpm

docker push ariadata/php-8.1:fpm-nginx

docker push ariadata/php-8.1:supervisor

echo "\n🔥 Pushing to dockerhub is Done!"