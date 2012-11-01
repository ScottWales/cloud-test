
# All hosts in the NCI framework should use this.

class nci {

	# This should be done by the rc.local (userdata) script
	# (which is in turn generated by the nova-boot wrapper),
	# but there's no harm in making sure things stay sane.
	file { '/puppet':
		ensure => link,
		target => "/etc/puppet",
	}

}