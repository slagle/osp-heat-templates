#!/bin/bash

exec > >(tee -a 02-network-provision.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}

source stackrc

time openstack overcloud network provision \
  -o overcloud-network-deployed-${STACK_NAME}.yaml \
  --stack ${STACK_NAME} \
  /home/stack/default-network-isolation.yaml \
  $@

date
