#! /bin/bash
# Запкстить контейнер с дженкинс внутри + первые команды

docker run -d --name jenkins_sf -p 8080:8080 jenkins:2.60.3
