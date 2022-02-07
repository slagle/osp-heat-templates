#!/bin/bash

exec > >(tee -a 04-node-provision.log)
exec 2>&1

set -eux
date

source stackrc

time openstack overcloud node provision \
  --stack overcloud \
  --overcloud-ssh-user cloud-user \
  --output /home/stack/overcloud-baremetal-deployed.yaml \
  /home/stack/overcloud-baremetal-deploy.yaml

date
