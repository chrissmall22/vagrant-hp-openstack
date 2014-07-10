vcsrepo { "/home/ubuntu/mininet":
    provider => git,
    ensure => present,
    user => "ubuntu",
    source => "git://github.com/mininet/mininet",
    revision => '2.1.0p1',
    before => Exec['Install Mininet']
}

exec { "Install Mininet":
    command => "/bin/bash mininet/util/install.sh -nfv > /dev/null",
    cwd => '/home/ubuntu',
    user => 'ubuntu',
    timeout => 0
}
