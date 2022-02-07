#!/bin/bash

exec > >(tee -a 02-network-provision.log)
exec 2>&1

set -eux
date

source stackrc

# For network isolation use:
# /usr/share/openstack-tripleo-heat-templates/network-data-samples/default-network-isolation.yaml
time openstack overcloud network provision \
  -o overcloud-network-deployed.yaml \
  --stack overcloud \
  /usr/share/openstack-tripleo-heat-templates/network_data_default.yaml \
  $@

date
