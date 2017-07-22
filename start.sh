#!/bin/bash

SETTINGS_LOCAL=/srv/ansible_ui/desktop/core/internal/settings_local.py

if [ ! -z '$DB_NAME' ]; then
    sed -i -e "s/'NAME': 'ansible',/'NAME': '$DB_USER',/g" $SETTINGS_LOCAL
fi

if [ ! -z '$DB_PASSWORD' ]; then
    sed -i -e "s/'PASSWORD': '****',/'PASSWORD': '$DB_PASSWORD',/g" $SETTINGS_LOCAL
fi

if [ ! -z '$DB_USER' ]; then
    sed -i -e "s/'USER': 'ansibleuser',/'USER': '$DB_USER',/g" $SETTINGS_LOCAL
fi

if [ ! -z '$DB_HOST' ]; then
    sed -i -e "s/'HOST': 'localhost',/'HOST': '$DB_HOST',/g" $SETTINGS_LOCAL
fi

if [ ! -z '$DB_PORT' ]; then
    sed -i -e "s/'PORT': '3306',/'PORT': '$DB_PORT',/g" $SETTINGS_LOCAL
fi

ANSIBLE_PLAYBOOK=`which ansible-playbook`

if [ ! -z '$ANSIBLE_PLAYBOOK' ]; then
    sed -i -e "s@ANSIBLE_PLAYBOOK = '/envansible_dir/bin/ansible-playbook'@ANSIBLE_PLAYBOOK = '$ANSIBLE_PLAYBOOK'@g" $SETTINGS_LOCAL
fi

sed -i \
    -e "s@/yourvirtualenv/bin/python@python@g" \
    -e "s@/ansible_ui_dir/@/srv/ansible_ui/@g" \
    -e "s@user = ansible@;user = ansible@g" \
    /srv/ansible_ui/celery-conf/supervisord.conf

cd /srv/ansible_ui/

python manage.py schemamigration desktop.apps.account --init
python manage.py schemamigration desktop.apps.ansible --init
python manage.py syncdb
python manage.py migrate ansible
python manage.py migrate account
python manage.py migrate kombu.transport.django
python manage.py migrate djcelery
python manage.py migrate guardian

cp ansible-conf/ansible.cfg ~/.ansible.cfg

# start

python manage.py runserver 0.0.0.0:8000