exec { "install btsync":
    command => "[ -e ~/.btsync ] || mkdir ~/.btsync && cd ~/.btsync && wget http://btsync.s3-website-us-east-1.amazonaws.com/btsync_arm.tar.gz && tar -xfv btsync_arm.tar.gz",
    path => "/bin:/usr/bin:/usr/local/bin"
}