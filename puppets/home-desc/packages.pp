
apt::ppa { "ppa:webupd8team/sublime-text-2": }
package { 'sublime-text':
    ensure => latest
}


package { 'mc':}

package { 'nautilus-dropbox': }

package { 'rdesktop': }

package { 'gparted':}
