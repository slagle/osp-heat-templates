#!/bin/bash

set -eux

ENVIRONMENT_NAME=${1:-""}
STACK_NAME=${STACK_NAME:-"osp17"}
SCRIPT_DIR=$(realpath $(dirname $0))
SSH_KEY=${SSH_KEY:-"$HOME/.ssh/${STACK_NAME}"}

if [ -z $ENVIRONMENT_NAME ]; then
    echo "Must provide environment file as first positional argument"
    echo "(e.g., master.yaml, osp17.yaml)"
    exit 1
else
    shift
fi

if [ ! -f ${SSH_KEY} ]; then
    ssh-keygen -N '' -f ${SSH_KEY}
fi

openstack stack create ${STACK_NAME} -t ${SCRIPT_DIR}/tripleo.yaml --wait \
    --parameter-file PrivateKeyContents=${SSH_KEY} \
    --parameter-file PublicKeyContents=${SSH_KEY}.pub \
    --parameter PublicKey="${SSH_KEY}.pub" \
    -e ${ENVIRONMENT_NAME} \
    $@

IP=$(openstack stack output show ${STACK_NAME} UndercloudFloatingIP -c output_value -f value)
ssh-keygen -R $IP
set +x
echo "Connect with SSH as:"
echo "ssh -i ${SSH_KEY} stack@${IP}"
