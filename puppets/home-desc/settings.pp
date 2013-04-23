#======  numlock ========#
#settitng numlock on to X

  package { 'numlockx':}

  exec { "set numlockx on":
         command => "sed -i 's|^exit 0.*$|# Numlock enable\n[ -x /usr/bin/numlockx ] \&\& numlockx on\n\nexit 0|' /etc/rc.local",
        unless => "grep -qe '^\[ -x /usr/bin/numlockx \] \&\& numlockx on' -- /etc/rc.local",
        path => "/bin:/usr/bin:/usr/local/bin",
  }


