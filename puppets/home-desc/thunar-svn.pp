apt::ppa { "ppa:rabbitvcs/ppa": }
package { 'rabbitvcs-thunar':}
package { 'rabbitvcs-cli':}
package { 'thunar-vcs-plugin':}



apt::ppa { "ppa:webupd8team/sublime-text-2": }
package { 'sublime-text':
    ensure => latest
}


package { 'mc':
    ensure => latest
}


