#!/bin/bash

exec > >(tee -a 01-undercloud-install.log)
exec 2>&1

set -eux
date

time openstack undercloud install

# Masquerade traffic for external network
sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/24 ! -d 10.0.0.0/24 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 192.168.24.0/24 ! -d 192.168.24.0/24 -j MASQUERADE

date
