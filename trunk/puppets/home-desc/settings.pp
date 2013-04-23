#======  numlock ========#
#settitng numlock on to X

  package { 'numlockx':}

  exec { "set numlockx on":
         command => "sed -i 's|^exit 0.*$|# Numlock enable\n[ -x /usr/bin/numlockx ] \&\& numlockx on\n\nexit 0|' /etc/rc.local",
        unless => "grep -qe '^\[ -x /usr/bin/numlockx \] \&\& numlockx on' -- /etc/rc.local",
        path => "/bin:/usr/bin:/usr/local/bin",
  }

#https://help.ubuntu.com/community/NumLock
# Turn Numlock on for the TTYs:
#for tty in /dev/tty[1-6]; do
#    /usr/bin/setleds -D +num < $tty
#done
