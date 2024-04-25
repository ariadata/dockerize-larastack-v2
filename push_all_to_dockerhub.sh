#!/bin/bash

echo "Start pushing 7.4" && cd ./7.4/ && bash push_to_dockerhub.sh && cd ..
# echo "Start pushing 8.0" && cd ./8.0/ && bash push_to_dockerhub.sh && cd ..
# echo "Start pushing 8.1" && cd ./8.1/ && bash push_to_dockerhub.sh && cd ..
echo "Start pushing 8.2" && cd ./8.2/ && bash push_to_dockerhub.sh && cd ..
echo "Start pushing 8.3" && cd ./8.3/ && bash push_to_dockerhub.sh && cd ..
