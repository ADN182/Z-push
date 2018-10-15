FROM nginx:alpine

WORKDIR /usr/share/z-push

ADD start.sh .

RUN mkdir /home/z-push-git \
	mkdir -p /usr/share/z-push/ /var/log/z-push/ /var/lib/z-push/ /home/z-push-git \
	chmod 775 /var/log/z-push/ /var/lib/z-push/ \
	chown -R nginx: /usr/share/z-push/ \
	chmod +x start.sh \
	chown -R nginx:nobody /var/log/z-push/ /var/lib/z-push/ \    
	
	apk update \
	apk add php5 php5-imap php5-fpm php5-posix php5-pdo php5-openssl php5-curl git  \
	sed -i "s/expose_php = On/expose_php = Off/" /etc/php5/php.ini \
	echo "; z-push configuration" >> /etc/php5/php-fpm.conf  \
	echo "php_flag[magic_quotes_gpci] = off" >> /etc/php5/php-fpm.conf  \
	echo "php_flag[register_globals] = off" >> /etc/php5/php-fpm.conf  \
	echo "php_flag[magic_quotes_runtime] = off" >> /etc/php5/php-fpm.conf \
	echo "php_flag[short_open_tag] = on" >> /etc/php5/php-fpm.conf \
  	echo "daemon off;" >> /etc/nginx/nginx.conf \
	sed -i "s/#gzip  on;/server_tokens off;/" /etc/nginx/nginx.conf \

	git clone -b master https://github.com/Z-Hub/Z-Push.git /home/z-push-git  \
	cp -r /home/z-push-git/src/* /usr/share/z-push/  \
	cp -r /home/z-push-git/config/nginx/z-push.conf /etc/nginx/conf.d/ \
	rm /etc/nginx/conf.d/default.conf  \
	ln -s /usr/share/z-push/z-push-admin.php /usr/sbin/z-push-admin  \
	ln -s /usr/share/z-push/z-push-top.php /usr/sbin/z-push-top  \
	apk del git  \
	rm -rf /var/cache/apk/*



CMD "./start.sh"
