

package { 'subversion':
    ensure => latest
}

package { 'puppet':
    ensure => latest
}

file { '/root/scripts':
    ensure  => directory,
    owner   => 'root',
    group   => 'root'  
}

cron { puppetService:
  command => "/root/scripts/pup-update",
  user    => root,
  hour    => '*/12'
}


file { '/root/scripts/pup-update':
    ensure  => present,          # файл должен существовать
    content =>  regsubst('#!/bin/bash
/root/scripts/pup-check -update >> /root/pup.log
', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
file {'/root/scripts/pup-check':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash

date -R

puppetsme=~/puppets.me
puppetsrep=~/puppets


case "$1" in
	"-install")
		echo $2 > $puppetsme 
		echo "installed"
		;;
	"-update")
		;;
	*)
		echo "usage pup-check {-install <deviceName> | -update }" 
		exit 1 ;;
esac
echo "updating" 
me=`cat $puppetsme`

svn co http://proj.googlecode.com/svn/trunk/puppets $puppetsrep

for pp in $(find $puppetsrep/$me/ -name *.pp;find $puppetsrep/all/ -name *.pp);
do
        echo
        echo "*******************************"
        echo $pp
        echo "*******************************"
        echo

        puppet apply $pp
done
echo OK!
', '\x0d', '', 'G'),

    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
