#!/bin/bash

echo "Start pushing 7.4\n"
docker tag ariadata/php-7.4:cli ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:cli
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:cli
docker tag ariadata/php-7.4:fpm ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:fpm
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:fpm
docker tag ariadata/php-7.4:fpm-nginx ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:fpm-nginx
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:fpm-nginx
docker tag ariadata/php-7.4:supervisor ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:supervisor
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-7.4:supervisor

echo "Start pushing 8.0\n"
docker tag ariadata/php-8.0:cli ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:cli
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:cli
docker tag ariadata/php-8.0:fpm ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:fpm
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:fpm
docker tag ariadata/php-8.0:fpm-nginx ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:fpm-nginx
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:fpm-nginx
docker tag ariadata/php-8.0:supervisor ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:supervisor
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.0:supervisor

echo "Start pushing 8.1\n"
docker tag ariadata/php-8.1:cli ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:cli
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:cli
docker tag ariadata/php-8.1:fpm ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:fpm
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:fpm
docker tag ariadata/php-8.1:fpm-nginx ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:fpm-nginx
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:fpm-nginx
docker tag ariadata/php-8.1:supervisor ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:supervisor
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.1:supervisor

echo "Start pushing 8.2\n"
docker tag ariadata/php-8.2:cli ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:cli
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:cli
docker tag ariadata/php-8.2:fpm ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:fpm
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:fpm
docker tag ariadata/php-8.2:fpm-nginx ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:fpm-nginx
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:fpm-nginx
docker tag ariadata/php-8.2:supervisor ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:supervisor
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.2:supervisor

echo "Start pushing 8.3\n"
docker tag ariadata/php-8.3:cli ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:cli
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:cli
docker tag ariadata/php-8.3:fpm ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:fpm
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:fpm
docker tag ariadata/php-8.3:fpm-nginx ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:fpm-nginx
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:fpm-nginx
docker tag ariadata/php-8.3:supervisor ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:supervisor
docker push ghcr.io/ariadata/dockerize-larastack-v2/php-8.3:supervisor
