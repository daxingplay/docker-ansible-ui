FROM alpine:3.6
MAINTAINER daxingplay <daxingplay@gmail.com>

ADD start.sh /

RUN apk add --no-cache --virtual .build-deps  \
        git \
        py2-pip \
        python2-dev \
        build-base \
        openldap-dev \
        mariadb-dev \
        bzip2-dev \
        coreutils \
        dpkg-dev dpkg \
        expat-dev \
        gcc \
        gdbm-dev \
        libc-dev \
        libffi-dev \
        linux-headers \
        make \
        ncurses-dev \
        libressl \
        libressl-dev \
        pax-utils \
        readline-dev \
        sqlite-dev \
        tcl-dev \
        tk \
        tk-dev \
        xz-dev \
        zlib-dev && \
    apk add --no-cache ca-certificates zlib libjpeg bash ansible supervisor python2 && \
    mkdir -p /srv/ansible_ui && \
    cd /srv/ && \
    git clone https://github.com/alaxli/ansible_ui.git ansible_ui && \
    cd /srv/ansible_ui && \
    pip install -r requirements.txt && \
    pip install Pillow --allow-external Pillow --allow-unverified Pillow && \
    apk del .build-deps

EXPOSE 8000

ENTRYPOINT ['bash', '/start.sh']
