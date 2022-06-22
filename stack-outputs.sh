#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}
SSH_KEY=${SSH_KEY:-"$HOME/.ssh/${STACK_NAME}"}
IP=${IP:-""}

if [ -z ${IP} ]; then
    IP=$(openstack stack output show ${STACK_NAME} UndercloudFloatingIP -c output_value -f value)
fi

ssh-keygen -R $IP
set +x
echo "Connect with SSH as:"
echo "ssh -i ${SSH_KEY} stack@${IP}"
