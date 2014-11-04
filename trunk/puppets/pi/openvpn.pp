package { 'openvpn':
    ensure => latest
}

file { '/root/.openvpn/openvpnd':
    ensure  => present,          # файл должен существовать
    content => regsubst('#!/bin/bash

        openvpn --config "/root/.openvpn/n.kolomeitsev.ovpn" --askpass "/root/.openvpn/.p"
        
        ', '\x0d', '', 'G'),
    mode    => 0700, 
    owner   => 'root',
    group   => 'root',
}

create_daemon {'openvpnd':
    name => "openvpnd",
    path => "/root/.openvpn/",
    require => package["openvpn"]
}

