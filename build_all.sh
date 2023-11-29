#!/bin/bash

# remove all images with pattern ariadata/php-:*
docker rmi -f $(docker images | grep ariadata/php- | awk '{print $3}')

echo "Building 7.4" && cd ./7.4/ && bash build.sh && cd ..
echo "Building 8.0" && cd ./8.0/ && bash build.sh && cd ..
echo "Building 8.1" && cd ./8.1/ && bash build.sh && cd ..
echo "Building 8.2" && cd ./8.2/ && bash build.sh && cd ..
echo "Building 8.3" && cd ./8.3/ && bash build.sh && cd ..
