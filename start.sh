#!/bin/sh
if [ ! -f "/usr/share/z-push/config.php" ]
then
    cp /home/z-push-git/config.php /usr/share/z-push/
fi

if [ ! -f "/usr/share/z-push/backend/imap/config.php" ]
then
    cp /home/z-push-git/backend/imap/config.php /usr/share/z-push/backend/imap/config.php
fi

if [ ! -f "/usr/share/z-push/backend/carddav/config.php" ]
then
    cp /home/z-push-git/backend/carddav/config.php /usr/share/z-push/backend/carddav/config.php
fi

if [ ! -f "/usr/share/z-push/backend/caldav/config.php" ]
then
    cp /home/z-push-git/backend/caldav/config.php /usr/share/z-push/backend/caldav/config.php
fi


if [ ! -f "/usr/share/z-push/backend/caldav/config.php" ]
then
    cp /home/z-push-git/backend/combined/config.php /usr/share/z-push/backend/combined/config.php
fi

php-fpm
nginx
