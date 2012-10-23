cloud-test
==========

Test repo for cloud computing

NCI has a git repository for puppet - repos.nci.org.au

Directory structure
-------------------

Puppet will load the file manifests/site.pp when performing a build. This file
in turn loads modules from that directory to install each program. In the NCI
repository a private directory is used to store rsa keys, this is only
accessable to members of a project group.

    manifests
        site.pp
    modules
        module-name
                files
                templates
                manifests
    private

Accessing
---------
Use nova command (python-novaclient) to access the NCI cloud.

You can query the capabilities with list commands
    
    # List images (ie. Ubuntu, Centos &c)
    $ nova image-list

    # List available ssh public keys
    $ nova keypair-list

    # List VM sizes (memory, number of cpus)
    $ nova flavor-list

    # List access types (ports open by default, e.g. ssh, http)
    $ nova secgroup-list

    # Boot an instance
    $ nova boot NAME --image IMAGE --key KEY --flavor FLAVOUR --security_groups SECGROUP --user-data USERDATA

User data is a shell script to be run once the VM has booted. It is used to run
puppet.

IP addresses must be assigned separately

    $ nova floating-ip-list
    $ nova add-floating-ip NAME IP

The melbourne directory of this repo includes scripts to start up a Ubuntu image
on the Melbourne Nectar cloud. It requires openstack credentials to have been
loaded into the environment, you will need to download this from the Nectar
cloud website.

Links:
------
puppetforge - contributed setup scripts
