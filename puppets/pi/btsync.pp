file { '/root/.btsync':
    ensure  => directory,          
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
file { '/root/.btsync/install':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash

        cd ~/.btsync 
        wget http://btsync.s3-website-us-east-1.amazonaws.com/btsync_arm.tar.gz 
        tar -xvf btsync_arm.tar.gz
        
        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root',
    require => File['/root/.btsync']
}

exec { "install btsync":
    command => "/root/.btsync/install",
    path => "/bin:/usr/bin:/usr/local/bin",
    creates => "/root/.btsync/btsync",
    require => File['/root/.btsync']
}

create_daemon {'btsync':
    name => "btsync",
    path => "/root/.btsync/",
    require => Exec["install btsync"]
}

