#!/bin/bash

exec > >(tee -a 03-vip-provision.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}
CLOUD_SUFFIX=${CLOUD_SUFFIX:-""}

source stackrc

# For network isolation, use:
# /usr/share/openstack-tripleo-heat-templates/network-data-samples/vip-data-default-network-isolation.yaml
time openstack overcloud network vip provision \
  -o overcloud-vip-deployed${CLOUD_SUFFIX}.yaml \
  --stack ${STACK_NAME} \
  /home/stack/vip-data-default.yaml \
  $@

date
