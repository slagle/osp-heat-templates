#!/bin/bash

exec > >(tee -a 01-undercloud-install.log)
exec 2>&1

set -eux
date

until timedatectl; do
    echo "Waiting for timedatectl (waiting for network?)..."
    sleep 1
done

time openstack undercloud install

date
