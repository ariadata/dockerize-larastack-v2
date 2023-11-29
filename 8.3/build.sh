#!/bin/bash

# exit when any command fails
set -e

docker build -t ariadata/php-8.3:cli ./cli/

docker build -t ariadata/php-8.3:fpm ./fpm/

docker build -t ariadata/php-8.3:fpm-nginx ./fpm-nginx/

docker build -t ariadata/php-8.3:supervisor ./supervisor/

echo "\n🔥 Build Done!"
