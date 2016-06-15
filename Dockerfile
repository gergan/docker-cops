FROM alpine:3.4
MAINTAINER Gergan Penkov <gergan at google.com>

RUN (echo "http://nl.alpinelinux.org/alpine/v3.4/main" > /etc/apk/repositories &&\
  echo "http://nl.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories &&\
  apk update &&\
  apk upgrade &&\
  apk add --no-cache --update git apache2 php5-apache2 curl php5-cli php5-json php5-xml php5-wddx php5-xmlreader php5-dom php5-xsl php5-phar php5-openssl php5-pdo php5-pdo_sqlite php5-gd php5-intl  && \
  rm -rf /var/www/localhost/htdocs && \
  git clone -b master https://github.com/seblucas/cops.git /var/www/localhost/htdocs && \
  sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
  sed -i 's/Group apache/Group www-data/g' /etc/apache2/httpd.conf && \
  mkdir /books && \
  mkdir /run/apache2/ && \
  chown -R apache:www-data /run/apache2 && \
  chown -R apache:www-data /var/www/localhost/htdocs && \
  rm -rf /var/cache/apk/*)

ADD files/config_local.php /var/www/localhost/htdocs/config_local.php

EXPOSE 80

# Expose volumes
VOLUME ["/books"]

ENTRYPOINT ["/usr/sbin/httpd"] 
CMD ["-D", "FOREGROUND"]
