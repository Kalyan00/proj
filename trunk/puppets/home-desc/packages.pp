apt::ppa { "ppa:rabbitvcs/ppa": }
package { 'rabbitvcs-thunar':
    ensure => latest
}
package { 'rabbitvcs-cli':
    ensure => latest
}
package { 'thunar-vcs-plugin':
    ensure => latest
}



apt::ppa { "ppa:webupd8team/sublime-text-2": }
package { 'sublime-text':
    ensure => latest
}


package { 'mc':
    ensure => latest
}


