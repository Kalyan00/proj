file { '/root/scripts':
    ensure  => directory,
    owner   => 'root',
    group   => 'root'  
}

cron { puppetService:
  command => "/root/scripts/pup-update",
  user    => root,
  minute  => '*/1'
}


file { '/root/scripts/pup-update':
    ensure  => present,          # файл должен существовать
    content => '/root/puppets/pup-check -update > /root/pup.log',  # содержимым файла должна являться строка "Hello, world!"
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
file {'/root/scripts/pup-check':
    ensure  => present,          # файл должен существовать
    content => '#!/bin/bash

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

',
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
