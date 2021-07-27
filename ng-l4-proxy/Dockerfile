FROM centos:7 as rpm_centos7

ENV NGINX_VERSION=1.20.1 \
    NG_L4_PROXY_VER=v1.0.0

RUN yum install -y \
      gcc \
      make \
      openssl \
      openssl-devel \
 && groupadd --system --gid 101 nginx \
 && useradd --system --no-create-home --shell /bin/false --gid 101 --uid 101 nginx \ 
 && curl -o nginx.tar.gz -SL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
 && tar -xzf nginx.tar.gz -C /tmp/ \
 && cd /tmp/nginx-* \
 && ./configure \
      --user=nginx \
      --group=nginx \
      --prefix=/usr/local/nginx \
      --with-http_ssl_module \
      --with-http_stub_status_module \
      --with-http_realip_module \
      --with-threads \
      --with-stream \
      --with-stream_ssl_preread_module \
      --with-stream_ssl_module \
 && make && make install \
 && rm -rf /nginx.tar.gz /tmp/nginx-* \
 && yum remove gcc make openssl-devel -y \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && rm -f /etc/localtime \
 && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
