#!/bin/bash

exec > >(tee -a 02-network-provision.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}
CLOUD_SUFFIX=${CLOUD_SUFFIX:-""}

source stackrc

# For network isolation use:
# /usr/share/openstack-tripleo-heat-templates/network-data-samples/default-network-isolation.yaml
time openstack overcloud network provision \
  -o overcloud-network-deployed${CLOUD_SUFFIX}.yaml \
  --stack ${STACK_NAME} \
  /usr/share/openstack-tripleo-heat-templates/network_data_default.yaml \
  $@

date
