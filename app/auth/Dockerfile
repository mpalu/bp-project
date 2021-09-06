FROM python:3.7-slim-buster@sha256:67a8667d477896fef5a399bf982e67bdb1a5b712ba88e95e33f94aa714be517e

RUN apt update && \
  apt install \
  python-pip \
  curl \
  bash \
  git \
  gcc \
  bzip2 \
  openssl \
  -y

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

ENV PATH=/root/.pyenv/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN pip install pipenv

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN pipenv install

CMD "pipenv" "run" "python" "src/server.py"

EXPOSE 8037