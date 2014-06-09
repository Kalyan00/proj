file { '/root/scripts/ssh-util':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash

        echo "/root/scripts/ssh-util"

        logfile=/var/log/ssh-util
        echo >> $logfile
        date >> $logfile


        sleeptime=32000
        sshpidport=`netstat -apn |grep sshd | grep -E "[:]$1 " | grep -o -E \'[0-9]+/sshd\' | grep -o -E \'[0-9]+\'|tail -n1`
        sshpidmy=`ps -o ppid --pid $$ |head -n 2 | tail -n 1 | grep -o -E \'[0-9]+\'`

        echo sshd_port = {$1} >> $logfile
        echo sshd_port = {$1}
        echo sshd_pid_port = {$sshpidport}  >> $logfile
        echo sshd_pid_port = {$sshpidport}
        echo sshd_pid_my = {$sshpidmy}  >> $logfile
        echo sshd_pid_my = {$sshpidmy}
        case "$sshpidport" in
          "" |"$sshpidmy" )
              echo nothing to kill. sleepeng $sleeptime  >> $logfile
              echo nothing to kill. sleepeng $sleeptime
              sleep $sleeptime
              date  >> $logfile
              echo sleepdone  >> $logfile
              echo sleepdone
              ;;
          *)      
              kill $sshpidport
              echo $sshpidport killed  >> $logfile
              echo $sshpidport killed
              ;;
            
        esac


        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}


ensure_key_value { 'sshd_config GatewayPorts': 
  file => '/etc/ssh/sshd_config',
  key => 'GatewayPorts',
  value => 'yes'
}