import "classes/*"

class git {
    package {'git':
        ensure => latest,
    }
}
define git::repo ($source) {
    include git
    exec { "git clone $source $title":  
        creates => $title
        path => '/usr/bin'
    }
}

class test-repo {
    git::repo{'/tmp/repo':
        source => "git://github.com/ScottWales/cloud-test"
    }
}

define prepend-path($path = "PATH"){
    exec { "echo PATH=$path:\$PATH >> /etc/bash.bashrc":
        # TODO: Don't add path if already in bashrc
    }
}
class cylc {
    git::repo{ '/usr/local/cylc' :
        source => "git://github.com/cylc/cylc"
    }
    prepend-path{ '/usr/local/cylc/bin' }
}

node default {
    include 'python-2_7'
    include 'clang'
    include test-repo
}
