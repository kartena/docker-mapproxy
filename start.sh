#!/bin/bash
USER_ID=`ls -lahn / | grep mapproxy | awk '{print $3}'`
GROUP_ID=`ls -lahn / | grep mapproxy | awk '{print $4}'`
USER_NAME=`ls -lah / | grep mapproxy | awk '{print $3}'`

groupadd -g $GROUP_ID mapproxy
useradd --shell /bin/bash --uid $USER_ID --gid $GROUP_ID $USER_NAME

# Create a default mapproxy config if one does not exist in /mapproxy
if [ ! -f /mapproxy.yaml ]
then
	su $USER_NAME -c "mapproxy-util create -t base-config mapproxy"
fi

su $USER_NAME -c "mapproxy-util create -t wsgi-app -f mapproxy.yaml mapproxy-prod-config.py"
su $USER_NAME -c "gunicorn --config = gunicorn-mapproxy.conf"