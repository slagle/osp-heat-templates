#!/bin/bash

exec > >(tee -a deploy.log)
exec 2>&1

set -eux
date

./01-undercloud-install.sh
./02-network-provision.sh
./03-vip-provision.sh
./04-node-provision.sh
./05-overcloud-deploy.sh

date
