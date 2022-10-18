#!/bin/bash

exec > >(tee -a 06-external-compute.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}

source stackrc


# Set up tripleo-ansible repo and download standalone-roles patches as explained in https://etherpad.opendev.org/p/tripleo-standalone-roles#L72

# Customize tripleo-ansible inventory.

# 1. Add host vars files under tripleo_ansible/inventory/host_vars/ for each external computes.
# https://etherpad.opendev.org/p/tripleo-standalone-roles#L89
# Example of tripleo_ansible/inventory/host_vars/compute-0
# ansible_host: 10.98.0.<%ip%>
# ctlplane_ip: 192.168.24.<%ip%>
# internal_api_ip: 172.16.2.<%ip%>
# tenant_ip: 172.16.0.<%ip%>
# fqdn_internal_api: <stack-name>-external-compute-<count>.localdomain

# <%ip%> depends on external computes count number. For external compute it starts from 160

# 2. Add ansible hosts to the compute host group in tripleo_ansible/inventory/02-computes

pushd /home/stack/tripleo-ansible

scripts/tripleo-standalone-vars --output-file 99-standalone-vars \
  -c /home/stack/overcloud-deploy/${STACK_NAME}/config-download/${STACK_NAME}

cp 99-standalone-vars tripleo_ansible/inventory/99-standalone-vars

time ansible-playbook -i tripleo_ansible/inventory \
  --become \
   tripleo_ansible/playbooks/deploy-overcloud-compute.yml \
  $@

date
