package { 'openvpn':
    ensure => latest
}

create_daemon {'openvpnd':
    name => "openvpn",
    args => "--config '/root/.openvpn/n.kolomeitsev.ovpn' --askpass '/root/.openvpn/.p'",
    require => package["openvpn"]
}

