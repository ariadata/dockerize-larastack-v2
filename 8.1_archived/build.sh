#!/bin/bash

# exit when any command fails
set -e
PHP_VERSION=8.1

docker build -t ariadata/php-$PHP_VERSION:cli ./cli/

docker build -t ariadata/php-$PHP_VERSION:fpm ./fpm/

docker build -t ariadata/php-$PHP_VERSION:fpm-nginx ./fpm-nginx/

docker build -t ariadata/php-$PHP_VERSION:supervisor ./supervisor/

echo "\n🔥 Build Done!"
