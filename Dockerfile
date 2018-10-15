FROM nginx:alpine

WORKDIR /usr/share/z-push

ADD start.sh .

RUN mkdir /home/z-push-git && \
	mkdir -p /usr/share/z-push/ /var/log/z-push/ /var/lib/z-push/ /home/z-push-git && \
	chmod 775 /var/log/z-push/ /var/lib/z-push/ && \
	chown -R nginx: /usr/share/z-push/ && \
	chmod +x start.sh  && \
	chown -R nginx:nobody /var/log/z-push/ /var/lib/z-push/  && \
	
	apk update  && \
	apk add php7 php7-cli php7-imap php7-fpm php7-posix php7-pdo php7-openssl php7-curl git && \
	sed -i "s/expose_php = On/expose_php = Off/" /etc/php7/php.ini  && \
	echo "; z-push configuration" >> /etc/php7/php-fpm.conf   && \
	echo "php_flag[magic_quotes_gpci] = off" >> /etc/php7/php-fpm.conf   && \
	echo "php_flag[register_globals] = off" >> /etc/php7/php-fpm.conf  && \
	echo "php_flag[magic_quotes_runtime] = off" >> /etc/php7/php-fpm.conf && \
	echo "php_flag[short_open_tag] = on" >> /etc/php7/php-fpm.conf && \
  	echo "daemon off;" >> /etc/nginx/nginx.conf  && \
	sed -i "s/#gzip  on;/server_tokens off;/" /etc/nginx/nginx.conf && \

	git clone -b master https://github.com/Z-Hub/Z-Push.git /home/z-push-git  && \
	cp -r /home/z-push-git/src/* /usr/share/z-push/   && \
	cp -r /home/z-push-git/config/nginx/z-push.conf /etc/nginx/conf.d/  && \
	rm /etc/nginx/conf.d/default.conf   && \
	ln -s /usr/share/z-push/z-push-admin.php /usr/sbin/z-push-admin  && \
	ln -s /usr/share/z-push/z-push-top.php /usr/sbin/z-push-top   && \
	apk del git   && \
	rm -rf /var/cache/apk/*



CMD "./start.sh"
