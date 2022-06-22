#!/bin/bash

exec > >(tee -a 01-undercloud-install.log)
exec 2>&1

set -eux
date

time openstack undercloud install $@

date
