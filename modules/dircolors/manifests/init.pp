
# Fix the colors in ls.

class dircolors {

	file { '/root/.dir_colors':
		ensure => present,
		source => "puppet:///modules/dircolors/dir_colors",
		owner => 'root',
		group => 'root',
		mode => 0644,
	}

	file { '/root/.bash_profile':
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => 0644,
		content => "eval `dircolors -b /root/.dir_colors`\nalias la='ls -la'\n",
	}

}
