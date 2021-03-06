define ensure_key_value($file, $key, $value, $delimiter = " ") {
    # append line if "$key" not in "$file"
    exec { "append $key$delimiter$value $file":
        command => "echo '$key$delimiter$value' >> $file",
        unless => "grep -qe '^[[:space:]]*$key[[:space:]]*$delimiter' -- $file",
        path => "/bin:/usr/bin:/usr/local/bin",
        before => Exec["update $key$delimiter$value $file"],
    }

    # update it if it already exists...
    exec { "update $key$delimiter$value $file":
        command => "sed --in-place='' --expression='s/^[[:space:]]*$key[[:space:]]*$delimiter.*$/$key$delimiter$value/g' $file",
        unless => "grep -xqe '$key$delimiter$value' -- $file",
        path => "/bin:/usr/bin:/usr/local/bin"
    }
}




define create_daemon($name, $args = "", $path = "/usr/sbin/"){
    
    $tail = 'PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

[ -x "$DAEMON" ] || exit 0
[ -r /etc/default/$NAME ] && . /etc/default/$NAME
. /lib/init/vars.sh
. /lib/lsb/init-functions

do_start()
{

	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON --test > /dev/null \
		|| return 1
	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- \
		$DAEMON_ARGS \
		|| return 2

}


do_stop()
{

	start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE --name $NAME
	RETVAL="$?"
	[ "$RETVAL" = 2 ] && return 2

	start-stop-daemon --stop --quiet --oknodo --retry=0/30/KILL/5 --exec $DAEMON
	[ "$?" = 2 ] && return 2

	rm -f $PIDFILE
	return "$RETVAL"
}


do_reload() {

	start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME
	return 0
}

case "$1" in
  start)
	[ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
	do_start
	case "$?" in
		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
		2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
	esac
	;;
  stop)
	[ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
	do_stop
	case "$?" in
		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
		2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
	esac
	;;
  status)
       status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
       ;;

  restart|force-reload)

	log_daemon_msg "Restarting $DESC" "$NAME"
	do_stop
	case "$?" in
	  0|1)
		do_start
		case "$?" in
			0) log_end_msg 0 ;;
			1) log_end_msg 1 ;; # Old process is still running
			*) log_end_msg 1 ;; # Failed to start
		esac
		;;
	  *)
	  	# Failed to stop
		log_end_msg 1
		;;
	esac
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

:
             '

    file { "/etc/init.d/$name":
        ensure  => present,  
        content => regsubst("#!/bin/bash
### BEGIN INIT INFO
# Provides:          skeleton
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: $name daemon
# Description:       $path$name $args daemon, created by create_daemon.pp
#
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC=\"$path$name $args daemon\"
NAME=$name
DAEMON_ARGS=\"$args\"
DAEMON=$path$name

$tail
", '\x0d', '', 'G'),
        mode    => 0700, 
        owner   => 'root',
        group   => 'root'  
    }
    
    service{"$name":
        enable => true,
        require => File["/etc/init.d/$name"]
    }
}