package { 'openvpn':
    ensure => latest
}

create_daemon {'openvpn':
    name => "openvpn",
    args => 'openvpn --config "/root/.openvpn/n.kolomeitsev.ovpn" --askpass "/root/.openvpn/.p"',
    require => package["openvpn"]
}

