#!/bin/bash

# exit when any command fails
set -e

docker build -t ariadata/php-8.1:cli ./cli/

docker build -t ariadata/php-8.1:fpm ./fpm/

docker build -t ariadata/php-8.1:fpm-nginx ./fpm-nginx/

docker build -t ariadata/php-8.1:supervisor ./supervisor/

echo "\n🔥 Build Done!"
