import "classes/*"

class git {
    package {'git':
        ensure => latest,
    }
}
define git::repo ($repo) {
    include git
    exec { "git clone $source $title":  
        creates => $title
    }
}
#define pip::package {
#    include pip
#    exec { "pip install $title":
#    }
#}

class test-repo {
    git::repo{'/tmp/repo':
        source => "git://github.com/ScottWales/cloud-test"
    }
}

node default {
    include 'python-2_7'
    include 'clang'
    include test-repo
}
