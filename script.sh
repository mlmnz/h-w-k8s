#/bin/bash
DOCKER_IMAGE=mlmnz/myapp
TEST_FILE=test_myApp.py
HELM_NAME_APP=myapp-helm
CHART=./myapp-chart
APP=myapp
echo -e "Test script =)\n"

echo -e "\033[1;34m ####### BUILD STAGE ####### \033[0m\n"
#We build the docker image with the Python App
docker build . -t ${DOCKER_IMAGE}



echo -e "\033[1;34m ####### TEST STAGE ####### \033[0m\n"
# Run basic test. Running a test_*.py file with docker 
docker run --rm ${DOCKER_IMAGE} python ${TEST_FILE}




echo -e "\033[1;34m ####### PACKAGE STAGE ####### \033[0m\n"
# Push the docker image created before to DockerHub. You will be login firts (docker login)
docker push ${DOCKER_IMAGE} 
# Package a chart directory into a chart archive create before with 'helm create'
helm package ${HELM_NAME_APP} ${CHART}



echo -e "\033[1;34m ####### DEPLOY STAGE ####### \033[0m\n"
helm install ${HELM_NAME_APP} ${CHART}



