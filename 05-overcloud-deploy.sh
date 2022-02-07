#!/bin/bash

exec > >(tee -a 05-overcloud-deploy.log)
exec 2>&1

set -eux
date

source stackrc

time openstack overcloud deploy \
  --overcloud-ssh-user cloud-user \
  --stack overcloud \
  --templates /usr/share/openstack-tripleo-heat-templates \
  --networks-file /usr/share/openstack-tripleo-heat-templates/network_data_default.yaml \
  --roles-file /usr/share/openstack-tripleo-heat-templates/roles_data.yaml \
  -e /home/stack/overcloud-network-deployed.yaml \
  -e /home/stack/overcloud-vip-deployed.yaml \
  -e /home/stack/overcloud-baremetal-deployed.yaml \
  -e /home/stack/overcloud-environment.yaml \
  -e /home/stack/container-image-prepare.yaml \
  $@

date
