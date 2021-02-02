#!/bin/bash

##Run SonarQube server

docker run -d --name sonarqube -p 9000:9000 sonarqube:7.5-community

## Run below command to check if a server is up and running

docker ps

## log in to SonarQube server on http://sonarqube.devops4me.com:9000 using default credentials: 
## login: admin
## password: admin

## http://sonarqube.devops4me.com:9000/account/security/ and generate a token. Copy token value and save it somewhere, since you won’t be able to see it again! 

## SonarQube Scanner

## Create a new folder for SonarQube scanner image dockerfile. 
mkdir sonarqube-scanner

## Build sonarqube-scanner image by executing following command in a console in sonarqube-scanner directory:

docker build --network=host --tag sonar-scanner-image:latest --build-arg SONAR_HOST="http://sonarqube.devops4me.com:9000" --build-arg SONAR_LOGIN_TOKEN="[TOKEN_VALUE]" .

## Setup example project : react-app

Run cd ..
Run git clone https://github.com/devops4mecode/sonarqube-react-app.git
Run cd sonarqube-react-app

## Add following .dockerignore file to the root directory:
.dockerignore
.vs

Open Dockerfile and replace it with the following code:

``
# It is our freshly build sonar-scanner-image from previous steps that
# is used here as a base image in docker file that we will be working on
FROM sonar-scanner-image:latest AS sonarqube_scan
# Here we are setting up a working directory to /app. It is like using `cd app` command
WORKDIR /app
# Copying all files from the project directory to our current location (/app) in image
# except patterns mention in .dockerignore
COPY . .
# Execution of example command. Here it is used to show a list of files and directories.
# It will be useful in later exercises in this tutorial. 
RUN ls -list
# To execute sonar-scanner we just need to run "sonar-scanner" in the image. 
# To pass Sonarqube parameter we need to add "-D"prefix to each as in the example below
# sonar.host.url is property used to define URL of Sonarqube server
# sonar.projectKey is used to define project key that will be used to distinguish it in 
# sonarqube server from other projects
# sonar.sources directory for sources of project
RUN sonar-scanner \
    -Dsonar.host.url="http://sonarqube.devops4me.com:9000" \
    -Dsonar.projectKey="SONAR_PROJECT_KEY" \
    -Dsonar.sources="src"
``
## 1st Analysis:
Run docker build --network=host --no-cache . in sonarqube-react-app directory
Enter http://sonarqube.devops4me.com:9000/dashboard?id=SONAR_PROJECT_KEY to see analysis results