#!/bin/bash

exec > >(tee -a 05-overcloud-deploy.log)
exec 2>&1

set -eux
date

STACK_NAME=${STACK_NAME:-"overcloud"}

source stackrc

time openstack overcloud deploy \
  --overcloud-ssh-user stack \
  --stack ${STACK_NAME} \
  --templates /usr/share/openstack-tripleo-heat-templates \
  --overcloud-ssh-user stack \
  --overcloud-ssh-key /home/stack/.ssh/id_rsa \
  --config-download \
  --disable-validations \
  -r /usr/share/openstack-tripleo-heat-templates/deployed-server/deployed-server-roles-data.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/deployed-server-environment.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/deployed-server-bootstrap-environment-rhel.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/config-download-environment.yaml \
  -e /home/stack/deployed-server-port-map.yaml \
  -e /home/stack/hostname-map.yaml \
  -e /home/stack/overcloud-environment.yaml \
  -e /home/stack/overcloud-images.yaml \
  $@

date
