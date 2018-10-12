#!/bin/sh
if [ ! -f "/usr/share/z-push/config.php" ]
then
    mv /home/z-push-git/config.php /usr/share/z-push/
fi

if [ ! -f "/usr/share/z-push/config.php" ]
then
    mv /home/z-push-git/config.php /usr/share/z-push/
fi

php-fpm
nginx
