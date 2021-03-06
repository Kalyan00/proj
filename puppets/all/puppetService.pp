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
    command => "/root/scripts/svn-update >> /var/log/puppetService",
    user    => root,
    minute  => '*/15'
}

file { '/root/scripts/pup-manual-update':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash
        
        /root/scripts/svn-update >> /var/log/puppetService &
        watch "cat /var/log/puppetService | tail && cat /root/pup.log.last"

        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}

file { '/root/scripts/svn-update':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash
        
        date -R
        echo "/root/scripts/svn-update"

        svnlog="/root/svn.log"
        svn co https://github.com/Kalyan00/proj/trunk /root/proj.googlecode.com > $svnlog
         
        for updater in $(find /root/scripts/svn-updaters);
        do
            $updater $svnlog
        done
        echo "OK"
        echo 

        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}

file { '/root/scripts/svn-updaters/pup-update':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash
        echo "/root/scripts/svn-updaters/pup-update"

        if [[ (  $1 == "" ) || (`cat $1 | grep ".pp"` != "") || ( `ls /root/pup.log.last` == "")]] ;
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






file { '/root/scripts/pup-check':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash
        echo "/root/scripts/pup-check"

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

        echo > /root/puppet_to_apply.pp
        
        for pp in $(find $puppetsrep/$me/ | grep "\.pp$";find $puppetsrep/all/ | grep "\.pp$");
        do
                echo >> /root/puppet_to_apply.pp
                echo "#"$pp >> /root/puppet_to_apply.pp
                echo >> /root/puppet_to_apply.pp
                cat $pp >> /root/puppet_to_apply.pp
                echo >> /root/puppet_to_apply.pp
        done
        puppet apply /root/puppet_to_apply.pp

        echo OK!
        ', '\x0d', '', 'G'),

    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
