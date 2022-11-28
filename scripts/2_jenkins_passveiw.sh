#! /bin/bash
# Посмотреть пароль администратора jenkins

docker exec jenkins_sf cat  /var/jenkins_home/secrets/initialAdminPassword
