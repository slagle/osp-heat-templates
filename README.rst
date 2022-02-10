==================
osp-heat-templates
==================

osp-heat-templates is a set of Heat templates to provision an OSP environment
on an OpenStack cloud (e.g., UpShift).

Examples
--------

Provision the environment
_________________________

::

  ./stack-create.sh

The create script generates a new SSH key under ~/.ssh that is used to connect
to the undercloud/director node.  When the stack is complete, SSH connection
information will be shown:

::

  Connect with SSH as:
  ssh -i /home/jslagle/.ssh/osp17 stack@10.0.126.190

Connect to the undercloud with the SSH command shown. In the ~stack directory,
there will be scripts to deploy the undercloud and overcloud. They should be
run in the order of their numerical prefix:

::

  ./01-undercloud-install.sh
  ./02-network-provision.sh
  ./03-vip-provision.sh
  ./04-node-provision.sh
  ./05-overcloud-deploy.sh

Or, executed all at once:

::

  ./deploy.sh

Everything is preconfigured, and the environment should come up with any
additional customization. Or, customize the provided scripts and environments
to tailor the environment to specific needs.
