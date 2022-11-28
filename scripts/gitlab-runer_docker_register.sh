#! /bin/bash 
# Зарегистрировать runner с $PROJECT_REGISTRATION_TOKEN токеном) 

docker run --rm -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "https://gitlab.com/" \
  --registration-token "GR1348941fXR2cAybfwWF4FMDbX4u" \
  --description "docker-runner" \
  --maintenance-note "Free-form maintainer notes about this runner" \
  --tag-list "docker,gitlab,github" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
