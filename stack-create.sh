#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}
SCRIPT_DIR=$(realpath $(dirname $0))
SSH_KEY=${SSH_KEY:-"$HOME/.ssh/${STACK_NAME}"}

if [ ! -f ${SSH_KEY} ]; then
    ssh-keygen -N '' -f ${SSH_KEY}
fi

openstack stack create ${STACK_NAME} -t ${SCRIPT_DIR}/osp17.yaml --wait \
    --parameter-file PrivateKeyContents=${SSH_KEY} \
    --parameter-file PublicKeyContents=${SSH_KEY}.pub \
    --parameter PublicKey="${SSH_KEY}.pub" \
    $@

IP=$(openstack stack output show ${STACK_NAME} DirectorFloatingIP -c output_value -f value)
ssh-keygen -R $IP
echo "Connect with SSH as:"
echo "ssh -i ${SSH_KEY} ${IP}"
