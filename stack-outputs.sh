#!/bin/bash

set -eux

STACK_NAME=${STACK_NAME:-"osp17"}

openstack stack output show ${STACK_NAME} DirectorFloatingIP
