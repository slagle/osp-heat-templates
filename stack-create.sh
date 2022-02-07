#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}
SCRIPT_DIR=$(realpath $(dirname $0))

openstack stack create ${STACK_NAME} -t ${SCRIPT_DIR}/osp17.yaml --wait $@
${SCRIPT_DIR}/stack-outputs.sh
