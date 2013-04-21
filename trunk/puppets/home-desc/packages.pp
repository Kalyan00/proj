
apt::ppa { "ppa:webupd8team/sublime-text-2": }
package { 'sublime-text':
    ensure => latest
}


package { 'mc':
    ensure => latest
}

package { 'nautilus-dropbox': }


package { 'rdesktop': }

