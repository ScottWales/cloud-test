cloud-test
==========

Test repo for cloud computing

NCI git - repos.nci.org.au

=== Directory structure ===
manifests
modules
    module-name
            files
            templates
            manifests
private

=== Accessing ===
Use nova command (python-novaclient) to access the NCI cloud
$ nova image-list
$ nova keypair-list
$ nova flavor-list
$ nova secgroup-list
$ nova boot NAME --image IMAGE --key KEY --flavor FLAVOUR --security_groups SECGROUP

Give a public IP
$ nova floating-ip-list
$ nova add-floating-ip NAME IP

Initialise puppet using nova's user data script

=== Links: ===
puppetforge - contributed setup scripts
