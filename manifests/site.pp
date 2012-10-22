# A stupid class that just creates a test file in /tmp, so that
# we can see if the puppet infrastructure is working or not.

class helloworld {
	file { '/tmp/helloworld':
		ensure => present,
		content => "Hello World!",
	}
}

import "classes/*"

node default {
    include helloworld
    include python-2.7
}
