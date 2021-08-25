FROM centos:7

ENV NGINX_VERSION=1.20.1 \
    NG_HTTP_PROXY_VER=v1.0.0

RUN yum install -y \
      patch \
      gcc \
      make \
      openssl \
      openssl-devel \
 && groupadd --system --gid 101 nginx \
 && useradd --system --no-create-home --shell /bin/false --gid 101 --uid 101 nginx \ 
 && curl -o nginx.tar.gz -SL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
 && tar -xzf nginx.tar.gz -C /tmp/ \
 && curl -o patch.tar.gz -SL https://github.com/chobits/ngx_http_proxy_connect_module/archive/refs/tags/v0.0.2.tar.gz \
 && tar -xzf patch.tar.gz -C /opt/ \
 && cd /tmp/nginx-* \
 && patch -p1 < /opt/ngx_http_proxy_connect_module-0.0.2/patch/proxy_connect_rewrite_1018.patch \
 && ./configure \
      --user=nginx \
      --group=nginx \
      --prefix=/usr/local/nginx \
      --add-module=/opt/ngx_http_proxy_connect_module-0.0.2 \
 && make && make install \
 && rm -rf /nginx.tar.gz /tmp/nginx-* \
 && yum remove gcc make openssl-devel -y \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && rm -f /etc/localtime \
 && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
