#!/bin/bash

exec > >(tee -a 05-overcloud-deploy.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}
CLOUD_SUFFIX=${CLOUD_SUFFIX:-""}

source stackrc

time openstack overcloud deploy \
  --overcloud-ssh-user stack \
  --stack ${STACK_NAME} \
  --templates /usr/share/openstack-tripleo-heat-templates \
  --networks-file /home/stack/default-network-isolation.yaml \
  --roles-file /usr/share/openstack-tripleo-heat-templates/roles_data.yaml \
  -e /home/stack/overcloud-network-deployed${CLOUD_SUFFIX}.yaml \
  -e /home/stack/overcloud-vip-deployed${CLOUD_SUFFIX}.yaml \
  -e /home/stack/overcloud-baremetal-deployed${CLOUD_SUFFIX}.yaml \
  -e /home/stack/overcloud-environment.yaml \
  -e /home/stack/container-image-prepare.yaml \
  $@

date
