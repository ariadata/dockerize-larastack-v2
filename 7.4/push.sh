#!/bin/bash

# exit when any command fails
set -e

docker push ariadata/php-7.4:cli

docker push ariadata/php-7.4:fpm

docker push ariadata/php-7.4:fpm-nginx

docker push ariadata/php-7.4:supervisor

echo "\n🔥 Pushing to dockerhub is Done!"