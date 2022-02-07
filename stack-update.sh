#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}
SCRIPT_DIR=$(realpath $(dirname $0))

openstack stack update ${STACK_NAME} -t ${SCRIPT_DIR}/osp17.yaml --existing --wait
${SCRIPT_DIR}/stack-outputs.sh
