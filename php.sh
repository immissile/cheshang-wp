DESC="php-fpm daemon"
NAME=php-fpm
# php-fpm路径
DAEMON=/usr/sbin/$NAME
# 配置文件路径
CONFIGFILE=/etc/$NAME.conf
# PID文件路径(在php-fpm.conf设置)
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/usr/sbin/$NAME
 
# Gracefully exit if the package has been removed.
test -x $DAEMON || exit 0
 
rh_start() {
  $DAEMON -y $CONFIGFILE || echo -n " already running"
}
 
rh_stop() {
  kill -QUIT `cat $PIDFILE` || echo -n " not running"
}
 
rh_reload() {
  kill -HUP `cat $PIDFILE` || echo -n " can't reload"
}
 
case "$1" in
  start)
        echo "Starting $DESC: $NAME"
        rh_start
        #echo "\n"
        ;;
  stop)
        echo "Stopping $DESC: $NAME"
        rh_stop
        #echo "\n"
        ;;
  reload)
        echo "Reloading $DESC configuration..."
        rh_reload
        echo "reloaded."
  ;;
  restart)
        echo "Restarting $DESC: $NAME"
        rh_stop
        sleep 1
        rh_start
        #echo "\n"
        ;;
  *)
         echo "Usage: $SCRIPTNAME {start|stop|restart|reload}" >&2
         exit 3
        ;;
esac
exit 0

