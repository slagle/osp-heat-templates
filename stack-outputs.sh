#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}
SSH_KEY=${SSH_KEY:-"$HOME/.ssh/${STACK_NAME}"}
IP=${IP:-""}
SSH_KEYGEN=${SSH_KEYGEN:-""}

if [ -z ${IP} ]; then
    IP=$(openstack stack output show ${STACK_NAME} UndercloudFloatingIP -c output_value -f value)
fi

if [ "${SSH_KEYGEN}" = "1" ]; then
    ssh-keygen -R $IP
fi

set +x
echo "Connect with SSH as:"
echo "ssh -i ${SSH_KEY} stack@${IP}"
