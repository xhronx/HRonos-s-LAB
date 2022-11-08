#! /bin/bash
# Запкстить контейнер с дженкинс внутри + первые команды

docker run -d --name jenkins_sf -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock jenkins:2.60.3
