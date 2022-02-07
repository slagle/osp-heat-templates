#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}

openstack stack delete --wait --yes ${STACK_NAME}
