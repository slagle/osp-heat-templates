#!/bin/bash

exec > >(tee -a 04-node-provision.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}

source stackrc

time openstack overcloud node provision \
  --stack ${STACK_NAME} \
  --overcloud-ssh-user stack \
  --output /home/stack/overcloud-baremetal-deployed-${STACK_NAME}.yaml \
  /home/stack/overcloud-baremetal-deploy.yaml \
  $@

date
