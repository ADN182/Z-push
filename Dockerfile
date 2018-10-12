FROM nginx:alpine


RUN mkdir /home/z-push-git && \
    mkdir -p /usr/share/z-push/ /var/log/z-push/ /var/lib/z-push/ /home/z-push-git && \
	  chmod 770 /var/log/z-push/ /var/lib/z-push/ /usr/share/z-push/ && \
    chown -R nginx:nobody z-push/ /var/log/z-push/ /var/lib/z-push/ /usr/share/z-push/  
    
RUN apk update && \
	apk add php5 php5-imap php5-fpm php5-posix php5-pdo git && \
  rm -rf /var/cache/apk/* && \
  echo "daemon off;" >> /etc/nginx/nginx.conf

RUN git clone -b master https://github.com/Z-Hub/Z-Push.git /home/z-push-git && \
      mv /home/z-push-git/src/* /usr/share/z-push/ && \
      mv /home/z-push-git/config/nginx/z-push.conf /etc/nginx/conf.d/ && \
      apk del git && \
      rm -rf /home/z-push-git/ 
  
