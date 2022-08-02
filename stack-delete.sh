#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}
SSH_KEY=${SSH_KEY:-"$HOME/.ssh/${STACK_NAME}"}

openstack stack delete --wait --yes ${STACK_NAME}
rm -f ${SSH_KEY}*
