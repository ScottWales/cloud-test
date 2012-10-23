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
    package { ['python2.7','graphviz','python-pip']:
        ensure => installed,
    }
    package { ['pyro','pygraphviz','jinja2']:
        ensure => installed,
        provider => pip
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
