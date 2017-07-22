FROM python:3-alpine3.6
MAINTAINER daxingplay <daxingplay@gmail.com>

ADD start.sh /

RUN apk add --no-cache bash git ansible supervisor && \
    mkdir -p /srv/ansible_ui && \
    git clone https://github.com/alaxli/ansible_ui.git /srv/ansible_ui && \
    cd /srv/ansible-ui && \
    pip install -r requirements.txt && \
    pip install PIL --allow-external PIL --allow-unverified PIL && \
    apk del git

EXPOSE 8000

ENTRYPOINT ['bash', '/start.sh']