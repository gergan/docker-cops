FROM alpine:3.3
MAINTAINER Gergan Penkov <gergan at google.com>

RUN (echo "http://nl.alpinelinux.org/alpine/v3.4/main" > /etc/apk/repositories &&\
  echo "http://nl.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories &&\
  apk update &&\
  apk upgrade &&\
#  apk add --no-cache --update tzdata musl libxslt zlib libxml2 mbedtls git php5-pdo php5-pdo_sqlite php5-gd php5-intl  && \
  apk add --no-cache --update git apache2 php5-apache2 curl php5-cli php5-json php5-xml php5-wddx php5-xmlreader php5-dom php5-xsl php5-phar php5-openssl php5-pdo php5-pdo_sqlite php5-gd php5-intl  && \
#  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  rm -rf /var/www/localhost/htdocs && \
  git clone -b master https://github.com/seblucas/cops.git /var/www/localhost/htdocs && \
#  echo "Europe/Berlin" > /etc/timezone && \
#  sed -i "s|;*date.timezone =.*|date.timezone = Europe/Berlin|i" /etc/php/php.ini && \
#  sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php/php.ini && \
#  sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = 50M|i" /etc/php/php.ini && \
#  sed -i "s|;*max_file_uploads =.*|max_file_uploads = 200|i" /etc/php/php.ini && \
#  sed -i "s|;*post_max_size =.*|post_max_size = 100M|i" /etc/php/php.ini && \
#  sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php/php.ini && \
#  apk del tzdata && \
#  sed -i 's#^DocumentRoot ".*#DocumentRoot "/www"#g' /etc/apache2/httpd.conf && \
  sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
  sed -i 's/Group apache/Group www-data/g' /etc/apache2/httpd.conf && \
  mkdir /books && \
  mkdir /run/apache2/ && \
  chown -R apache:www-data /run/apache2 && \
  chown -R apache:www-data /var/www/localhost/htdocs && \
#  chown -R web-srv:www-data /etc/hiawatha/conf.d && \
  rm -rf /var/cache/apk/*)

#USER web-srv
WORKDIR /www
ADD files/config_local.php /var/www/localhost/htdocs/config_local.php

EXPOSE 80

# Expose volumes
VOLUME ["/books"]

ENTRYPOINT ["/usr/sbin/httpd"] 
CMD ["-D", "FOREGROUND"]
