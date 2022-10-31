#! /bin/bash
# Запустить докер с gitlab-ранером внутри ++

docker run -d --name gitlab-runner --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  gitlab/gitlab-runner

docker exec gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "shell" \
  --url "https://gitlab.com/" \
  --registration-token "GR1348941fXR2cAybfwWF4FMDbX4u" \
  --run-untagged="true" \