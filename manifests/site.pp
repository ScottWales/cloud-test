# A stupid class that just creates a test file in /tmp, so that
# we can see if the puppet infrastructure is working or not.

class helloworld {
	file { '/tmp/helloworld':
		ensure => present,
		content => "Hello World!",
	}
}

node default {
    include helloworld
}
