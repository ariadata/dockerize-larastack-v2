#!/bin/bash
set -euo pipefail

# remove all images with pattern ariadata/php-*
# use -q / --filter — docker images default table is not machine-parseable
# ids=$(docker images -q --filter 'reference=ariadata/php-*' || true)
# if [ -n "$ids" ]; then
# 	docker rmi -f $ids
# fi

echo "Building 7.4" && cd ./7.4/ && bash build.sh && cd ..
echo "Building 8.0" && cd ./8.0/ && bash build.sh && cd ..
echo "Building 8.1" && cd ./8.1/ && bash build.sh && cd ..
echo "Building 8.2" && cd ./8.2/ && bash build.sh && cd ..
echo "Building 8.3" && cd ./8.3/ && bash build.sh && cd ..
echo "Building 8.4" && cd ./8.4/ && bash build.sh && cd ..
echo "Building 8.5" && cd ./8.5/ && bash build.sh && cd ..
