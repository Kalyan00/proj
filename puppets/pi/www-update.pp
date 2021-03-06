file { '/var/www':
    ensure  => directory,
}


package { 'lftp':
    ensure => latest
}

file { '/root/scripts/svn-updaters/www-update':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash

        echo "/root/scripts/svn-updaters/www-update"

        if [[ (  $1 == "" ) || (`cat $1 | grep "js_cms"` != "" ) || ( `cat /var/jsstatus` != "ok" ) ]];
        then
            echo run > /var/jsstatus
            echo wwwupdate
            rm -r /var/www/js_cms
            echo svn export
            svn export /root/proj.googlecode.com/www/js_cms /var/www/js_cms
            echo chmod
            chmod 777 -R /var/www/js_cms
            #echo lftp 1
            #lftp -e \'mirror -R /var/www/js_cms /cms; bye;\' -u xarlamov.i,6189518 ftp.narod.ru
            echo lftp 2
            #lftp -e \'mirror -R /var/www/js_cms /http; bye;\' -u w_aharlamov-ru_48ff5785,4152c26d aharlamov-ru.1gb.ru
            lftp -e \'set ftp:ssl-allow no; mirror -R /var/www/js_cms /http; bye;\' -u w_aharlamov-ru_48ff5785,4152c26d aharlamov.ru
            echo ok > /var/jsstatus            
        fi

        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}