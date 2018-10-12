FROM nginx:alpine


RUN mkdir /home/z-push-git && \
    mkdir -p /usr/share/z-push/ /var/log/z-push/ /var/lib/z-push/ /home/z-push-git && \
    chmod 755 /var/log/z-push/ /var/lib/z-push/ && \
    chown -R nginx: /usr/share/z-push/ && \
    chown -R nginx:nginx /var/log/z-push/ /var/lib/z-push/ 
    
RUN 	apk update && \
	apk add php5 php5-imap php5-fpm php5-posix php5-pdo git && \
  	echo "daemon off;" >> /etc/nginx/nginx.conf

RUN git clone -b master https://github.com/Z-Hub/Z-Push.git /home/z-push-git && \
      mv /home/z-push-git/src/* /usr/share/z-push/ && \
      mv /home/z-push-git/config/nginx/z-push.conf /etc/nginx/conf.d/ && \
      ln -s /usr/share/z-push/z-push-admin.php /usr/sbin/z-push-admin && \
      ln -s /usr/share/z-push/z-push-top.php /usr/sbin/z-push-top && \
      apk del git && \
      rm -rf /var/cache/apk/* && \
      rm -rf /home/z-push-git/ 
  
