#! /bin/bash
# cAdvisor (Container Advisor) — написанный на Go агрегатор информации о состоянии контейнеров на хосте.

docker run \
              --volume=/:/rootfs:ro \
              --volume=/var/run:/var/run:ro \
              --volume=/sys:/sys:ro \
              --volume=/var/lib/docker/:/var/lib/docker:ro \
              --volume=/dev/disk/:/dev/disk:ro \
              --publish=8080:8080 \
              --detach=true \
              --name=cadvisor \
              --privileged \
              --device=/dev/kmsg \
              gcr.io/cadvisor/cadvisor:latest
