FROM nginx:alpine


RUN mkdir /home/z-push-git && \
    mkdir -p /usr/share/z-push/ /var/log/z-push/ /var/lib/z-push/ /home/z-push-git && \
    chmod 775 /var/log/z-push/ /var/lib/z-push/ && \
    chown -R nginx: /usr/share/z-push/ && \
    chown -R nginx:nobody /var/log/z-push/ /var/lib/z-push/ 
    
RUN 	apk update && \
	apk add php5 php5-imap php5-fpm php5-posix php5-pdo php5-openssl php5-curl git && \
  	echo "daemon off;" >> /etc/nginx/nginx.conf

RUN git clone -b master https://github.com/Z-Hub/Z-Push.git /home/z-push-git && \
      mv /home/z-push-git/src/* /usr/share/z-push/ && \
      mv /home/z-push-git/config/nginx/z-push.conf /etc/nginx/conf.d/ && \
      rm /etc/nginx/conf.d/default.conf && \
      ln -s /usr/share/z-push/z-push-admin.php /usr/sbin/z-push-admin && \
      ln -s /usr/share/z-push/z-push-top.php /usr/sbin/z-push-top && \
      apk del git && \
      rm -rf /var/cache/apk/* && \


ADD start.sh	/usr/share/z-push/

CMD "./usr/share/z-push/start.sh"
