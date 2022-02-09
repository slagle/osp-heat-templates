#!/bin/bash

exec > >(tee -a 04-node-provision.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}
CLOUD_SUFFIX=${CLOUD_SUFFIX:-""}

source stackrc

time openstack overcloud node provision \
  --stack ${STACK_NAME} \
  --overcloud-ssh-user stack \
  --output /home/stack/overcloud-baremetal-deployed${CLOUD_SUFFIX}.yaml \
  /home/stack/overcloud-baremetal-deploy${CLOUD_SUFFIX}.yaml

date
