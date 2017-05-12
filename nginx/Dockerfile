#
# Dockerfile for building Nginx images
#

FROM xiao/ubuntu
MAINTAINER YuXiao <xiao.950901@gmail.com>

ADD src/pcre-8.40.tar.gz /mnt/
ADD src/openssl-1.0.2k.tar.gz /mnt/
ADD src/zlib-1.2.11.tar.gz /mnt/
ADD src/nginx-1.12.0.tar.gz /mnt

RUN groupadd -r nginx && useradd -r -g nginx -s /sbin/nologin nginx

WORKDIR /mnt/nginx-1.12.0

RUN \
./configure --prefix=/usr/local/nginx \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/lock/nginx.lock \
    --user=nginx \
    --group=nginx \
    --with-openssl=/mnt/openssl-1.0.2k \
    --with-pcre=/mnt/pcre-8.40 \
    --with-zlib=/mnt/zlib-1.2.11 \
    --with-http_ssl_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_realip_module \
    --with-http_gzip_static_module \
    --with-http_stub_status_module \
    --with-mail \
    --with-mail_ssl_module \
    --http-client-body-temp-path=/var/tmp/nginx/client \
    --http-proxy-temp-path=/var/tmp/nginx/proxy \
    --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
    --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
    --http-scgi-temp-path=/var/tmp/nginx/scgi \
    --with-debug

RUN \
  make && make install && \
  mkdir -p /var/tmp/nginx/{client,proxy,fastcgi,uwsgi,scgi} && \
  mkdir -p /data/www && \
  chown -R nginx:nginx /data/www && \
  ln -s /usr/local/nginx/sbin/nginx /usr/sbin/nginx && \
  rm -rf /mnt/{pcre-8.40,openssl-1.0.2k,zlib-1.2.11,nginx-1.12.0}

COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY conf/fastcgi.conf /usr/local/nginx/conf/fastcgi.conf

WORKDIR /root

EXPOSE 80

VOLUME ["/data/www"]

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
