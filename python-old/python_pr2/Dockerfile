FROM python:3.6-alpine as base

FROM base as builder

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install pipenv

WORKDIR /install

# creation of requirements.txt
COPY ./requirements.txt ./requirements.txt

# everything else stays the same
RUN pip install -r ./requirements.txt

FROM base

COPY --from=builder /install /usr/local
COPY .  /app
RUN apk --no-cache add libpq
WORKDIR /app