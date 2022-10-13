#! /bin/bash
# add user to use docker

sudo groupadd docker
sudo gpasswd -a ${USER} docker
newgrp docker
sudo service docker restart
