#
# Dockerfile for building PHP7 images
#

FROM xiao/ubuntu
MAINTAINER YuXiao <xiao.950901@gmail.com>

ADD src/php-5.6.30.tar.gz /mnt/

RUN \
  apt-get update && \
  apt-get install -y pkg-config libxml2 libxml2-dev bzip2 libbz2-dev \
  libcurl3 libcurl4-openssl-dev libjpeg-dev libpng12-dev libreadline-dev \
  libfreetype6-dev libmcrypt4 libmcrypt-dev libssl-dev

WORKDIR /mnt/php-5.6.30

RUN ./configure \
  --prefix=/usr/local/php \
  --with-config-file-path=/usr/local/php/etc \
  --with-mysql=mysqlnd \
  --with-mysqli=mysqlnd \
  --with-pdo-mysql=mysqlnd \
  --with-libxml-dir \
  --with-gd \
  --with-jpeg-dir \
  --with-freetype-dir \
  --with-iconv-dir \
  --with-bz2 \
  --with-zlib \
  --with-curl \
  --with-openssl \
  --with-mcrypt \
  --with-mhash \
  --with-readline \
  --with-gettext \
  --with-pcre-regex \
  --enable-inline-optimization \
  --enable-soap \
  --enable-gd-native-ttf \
  --enable-mbstring \
  --enable-mbregex \
  --enable-sockets \
  --enable-exif \
  --enable-mysqlnd \
  --enable-json \
  --enable-zip \
  --enable-fpm \
  --enable-shmop \
  --enable-sysvmsg \
  --enable-sysvsem \
  --enable-sysvshm \
  --enable-pcntl \
  --disable-debug \
  --disable-rpath \
  --disable-ipv6

RUN \
  make && make install && \
  cp php.ini-production /usr/local/php/etc/php.ini && \
  cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \
  chmod +x /etc/init.d/php-fpm && \
  cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
  groupadd -r nginx && useradd -r -g nginx -s /sbin/nologin nginx && \
  rm -rf /mnt/php-5.6.30

RUN \
  sed -i "s%;cgi.fix_pathinfo=1%cgi.fix_pathinfo=1%g" /usr/local/php/etc/php.ini && \
  sed -i "s%;date.timezone =%;date.timezone = Asia/Shanghai%g" /usr/local/php/etc/php.ini && \
  sed -i "s%;pid = run/php-fpm.pid%pid = run/php-fpm.pid%g" /usr/local/php/etc/php-fpm.conf && \
  sed -i "s%user = nobody%user = nginx%" /usr/local/php/etc/php-fpm.conf && \
  sed -i "s%group = nobody%group = nginx%" /usr/local/php/etc/php-fpm.conf && \
  sed -i "s%listen = 127.0.0.1:9000%listen = 9000%" /usr/local/php/etc/php-fpm.conf && \
  sed -i "s%;daemonize = yes%daemonize = no%" /usr/local/php/etc/php-fpm.conf

EXPOSE 9000

ENTRYPOINT ["/usr/local/php/sbin/php-fpm", "-F", "-c", "/usr/local/php/etc/php.ini"]
