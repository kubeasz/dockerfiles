# Download extral binaries needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-ext-build
# @ref:     https://github.com/easzlab/kubeasz

FROM centos:7 as rpm_centos7

ENV NGINX_VERSION=1.20.2
ENV CHRONY_VERSION 4.0
ENV CHRONY_DOWNLOAD_URL "https://download.tuxfamily.org/chrony/chrony-${CHRONY_VERSION}.tar.gz"
ENV CHRONY_SHA256 be27ea14c55e7a4434b2fa51d53018c7051c42fa6a3198c9aa6a1658bae0c625
ENV KEEPALIVED_VERSION 2.0.20
ENV KEEPALIVED_DOWNLOAD_URL "http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz"

RUN yum install -y \
      gcc \
      make \
      openssl \
      openssl-devel \
 && curl -o nginx.tar.gz -SL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
 && tar -xzf nginx.tar.gz -C /tmp/ \
 && cd /tmp/nginx-* \
 && ./configure --with-stream \
                --without-http \
                --without-http_uwsgi_module \
                --without-http_scgi_module \
                --without-http_fastcgi_module \
 && make && make install \
 && cd / \
 && curl -o chrony.tar.gz -SL $CHRONY_DOWNLOAD_URL \
 && echo "${CHRONY_SHA256} *chrony.tar.gz" | sha256sum -c - \
 && tar xzf chrony.tar.gz -C /tmp/ \
 && cd /tmp/chrony* \
 && ./configure \
        --without-editline \
        --disable-sechash \
        --disable-nts \
        --disable-ipv6 \
        --disable-privdrop \
        --without-libcap \
        --without-seccomp \
        --disable-asyncdns \
        --disable-cmdmon \
  && make && make install \
  && cd / \
  && curl -o keepalived.tar.gz -SL $KEEPALIVED_DOWNLOAD_URL \
  && tar xzf keepalived.tar.gz -C /tmp/ \
  && cd /tmp/keepalived* \
  && ./configure \
		--disable-dynamic-linking \
		--disable-FEATURE \
      --disable-lvs \
		--disable-vrrp-auth \
		--disable-routes \
		--disable-linkbeat \
		--disable-iptables \
		--disable-libipset-dynamic \
		--disable-nftables \
		--disable-hardening \
		--with-init=systemd \
  && make && make install

FROM alpine:3.12

ENV EXT_BUILD_VER=1.0.0

COPY --from=rpm_centos7 /usr/local/nginx/sbin/nginx /bin
COPY --from=rpm_centos7 /usr/local/sbin/chronyd /bin
COPY --from=rpm_centos7 /usr/local/sbin/keepalived /bin

CMD [ "sleep", "360000000" ]
