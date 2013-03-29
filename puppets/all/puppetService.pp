

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

file { '/root/scripts/svn-updaters':
    ensure  => directory,
    owner   => 'root',
    group   => 'root'  
}

cron { puppetService:
    command => "/root/scripts/svn-update",
    user    => root,
    minute  => '*/3'
}

file { '/root/scripts/svn-update':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash

        svnlog="/root/svn.log"
        svn co http://proj.googlecode.com/svn/trunk /root/proj.googlecode.com > $svnlog
         
        for updater in $(find /root/scripts/svn-updaters);
        do
            $updater $svnlog
        done


        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}

file { '/root/scripts/svn-updaters/pup-update':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash
        echo "svn-updaters/pup-update"
        if [[ $1 == "" ]] ;
        then
            echo "empty param"
            exit 1
        fi

        if [[ (`cat $1 | grep ".pp"` != "") || ( `ls /root/pup.log.last` == "")]] ;
        then
            echo "svn-updaters/pup-update started"
            /root/scripts/pup-check -update > /root/pup.log.last
            cat /root/pup.log.last >> /root/pup.log
        fi

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
        puppetsrep=/root/proj.googlecode.com/puppets


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
