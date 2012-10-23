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
    }
}
define git::repo_branch ($source, $branch) {
    include git
    exec { "git clone $source $title --branch $branch":  
        creates => $title,
    }
}

define prepend-path($path = "PATH"){
    exec { "echo PATH=$title:\$PATH >> /etc/bash.bashrc":
        # TODO: Don't add path if already in bashrc
    }
}

class python {
    package { ['python2.7-dev','python2.7']:
        ensure => installed,
    }
    package { ['python-pip']:
        ensure => installed,
        require => Package['python2.7'],
    }
}
class pygtk {
	include python
    package { 'python-gtk2':
        ensure => installed,
        require => Package['python2.7'],
    }
}
class jinja {
include python
    package { ['jinja2']:
        ensure => installed,
        provider => pip,
        require => Package['python-pip'],
    }
}

class cylc {
	include python
include pygtk
include jinja
    package { ['graphviz-dev','gcc','pkg-config']:
	ensure => installed,
    }
    package { ['pyro']:
        ensure => installed,
        provider => pip,
        require => Package['python-pip'],
    }
    package { 'pygraphviz':
        ensure => installed,
        provider => pip,
        require =>
        Package['python2.7-dev','python-pip','graphviz-dev','gcc','pkg-config'],
    }

    git::repo{ '/usr/local/cylc' :
        source => "git://github.com/cylc/cylc"
    }
    prepend-path{ '/usr/local/cylc/bin':
    }
}

class rose {
	include python
include pygtk
include jinja
    package { ['subversion']:
        ensure => installed,
    }
    package { ['cherrypy','requests','simplejson','sqlalchemy']:
        ensure => installed,
        provider => pip,
        require => Package['python-pip'],
    }

    include cylc
    git::repo{ '/usr/local/rose' :
        source => "git://github.com/metomi/rose.git"
    }
    prepend-path{ 'usr/local/rose/bin' :
    }
}

node default {
    include cylc
    include rose
}
