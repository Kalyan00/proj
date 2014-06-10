exec { "install btsync":
    command => "bash -c '[ -e ~/.btsync ] || mkdir ~/.btsync && cd ~/.btsync && wget http://btsync.s3-website-us-east-1.amazonaws.com/btsync_arm.tar.gz && tar -xvf btsync_arm.tar.gz || cd ~ && rm -rf ~/.btsync '",
    path => "/bin:/usr/bin:/usr/local/bin"
}