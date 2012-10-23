import "classes/*"

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class git {
    package {'git':
        ensure => latest,
    }
}
define git::repo ($source) {
    include git
    exec { "git clone $source $title":  
        creates => $title,
        path => '/usr/bin',
    }
}

define prepend-path($path = "PATH"){
    exec { "echo PATH=$title:\$PATH >> /etc/bash.bashrc":
        # TODO: Don't add path if already in bashrc
    }
}

class cylc {
    package { ['python2.7-dev','python2.7','graphviz-dev','gcc','pkg-config']:
        ensure => installed,
    }
    package { ['python-pip','python-gtk2']:
        ensure => installed,
        require => Package['python2.7'],
    }
    package { ['pyro','jinja2']:
        ensure => installed,
        provider => pip,
        require => Package['python-pip'],
    }
    package { 'pygraphviz':
        ensure => installed,
        provider => pip,
        require =>
        Package['python2.7-dev','python-pip','graphviz','graphviz-dev','gcc','pkg-config'],
    }

    git::repo{ '/usr/local/cylc' :
        source => "git://github.com/cylc/cylc"
    }
    prepend-path{ '/usr/local/cylc/bin':
    }
}

node default {
    include cylc
}
