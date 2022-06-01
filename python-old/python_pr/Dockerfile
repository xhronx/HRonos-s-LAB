FROM python:3.6-alpine as base

FROM base as builder

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install pipenv

WORKDIR /srv/app/

#RUN apt update && \
#    apt install --no-install-recommends -y build-essential gcc && \
#    apt clean && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt /requirements.txt
COPY ./ /srv/app/web.py

#RUN pip3 install --upgrade pip
#RUN pip3 install --no-cache-dir -r /requirements.txt
CMD ['python3', '/srv/app/web.py']

EXPOSE 80