
# Hosts that can be ssh'd into.

class ssh {

	package { 'openssh-server':
		ensure => present,
		before => File['/etc/ssh/sshd_config'],
	}

	file { '/etc/ssh/sshd_config':
		ensure => file,
		mode   => 600,
	}

	service { 'sshd':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		subscribe  => File['/etc/ssh/sshd_config'],
	}

	define host_keys {
		# Still a bit too much repetition here...
		file {
		"/etc/ssh/ssh_host${title}key.pub":
			ensure => present,
			source => "/puppet/private/keys/hostkeys/ssh_host${title}key.pub",
			mode => 0644,
			owner => 'root',
			group => 'root',
			require => Package['openssh-server'],
			notify => Service['sshd'],
		;
		"/etc/ssh/ssh_host${title}key":
			ensure => present,
			source => "/puppet/private/keys/hostkeys/ssh_host${title}key",
			mode => 0600,
			owner => 'root',
			group => 'root',
			require => Package['openssh-server'],
			notify => Service['sshd'],
		}
	}

	# The empty string is false, which leads to this inelegance.
	host_keys { ["_", "_dsa_", "_ecdsa_", "_rsa_"]: } 

}
