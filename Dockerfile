FROM alpine:3.6
MAINTAINER daxingplay <daxingplay@gmail.com>

ADD start.sh /start.sh

# cn mirror
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && 、
#    mkdir ~/.pip && \
#    echo "[global]\nindex-url = https://mirrors.ustc.edu.cn/pypi/web/simple\nformat = columns" > ~/.pip/pip.conf

RUN apk add --no-cache --virtual .build-deps  \
        git \
        py2-pip \
        python2-dev \
        build-base \
        openldap-dev \
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
        libjpeg-turbo-dev \
        jpeg-dev \
        zlib-dev && \
    apk add --no-cache ca-certificates bash ansible supervisor python2 mariadb-dev && \
    mkdir -p /srv/ansible_ui && \
    cd /srv/ && \
    git clone https://github.com/alaxli/ansible_ui.git ansible_ui && \
    cd /srv/ansible_ui && \
    pip install -r requirements.txt && \
    pip install Pillow && \
    apk del .build-deps && \
    chmod +x /start.sh

EXPOSE 8000

CMD ["/start.sh"]
