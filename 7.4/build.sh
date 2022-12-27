#!/bin/bash

# exit when any command fails
set -e

docker build -t ariadata/php-7.4:cli ./cli/

docker build -t ariadata/php-7.4:fpm ./fpm/

docker build -t ariadata/php-7.4:fpm-nginx ./fpm-nginx/

docker build -t ariadata/php-7.4:supervisor ./supervisor/

echo "\n🔥 Build Done!"
