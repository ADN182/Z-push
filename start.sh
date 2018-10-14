#!/bin/sh

if [ ! -f "/etc/ngnix/z-push.conf" ]
then
    cp /home/z-push-git/build/ /etc/ngnix/z-push.conf
fi

if [ ! -f "/usr/share/z-push/config.php" ]
then
    cp /home/z-push-git/src/config.php /usr/share/z-push/
fi

if [ ! -f "/usr/share/z-push/backend/imap/config.php" ]
then
    cp /home/z-push-git/src/backend/imap/config.php /usr/share/z-push/backend/imap/config.php
fi

if [ ! -f "/usr/share/z-push/backend/carddav/config.php" ]
then
    cp /home/z-push-git/src/ackend/carddav/config.php /usr/share/z-push/backend/carddav/config.php
fi

if [ ! -f "/usr/share/z-push/backend/caldav/config.php" ]
then
    cp /home/z-push-git/src/backend/caldav/config.php /usr/share/z-push/backend/caldav/config.php
fi


if [ ! -f "/usr/share/z-push/backend/caldav/config.php" ]
then
    cp /home/z-push-git/src/backend/combined/config.php /usr/share/z-push/backend/combined/config.php
fi

php5-fpm
nginx
