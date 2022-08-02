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

  export STACK_NAME=my_osp17
  export ENVIRONMENT_NAME=osp17
  ./stack-create.sh


The supported options for ${ENVIRONMENT_NAME} are osp17, master, and osp13.
${STACK_NAME} can be any string value.

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

Further Examples
________________

Deploy additional Compute nodes:

::

  ./stack-create.sh --parameter ComputeCount=10

Use a different stack name (default is osp17):

::

  STACK_NAME=custom-stack ./stack-create.sh
