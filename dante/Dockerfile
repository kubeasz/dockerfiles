FROM centos:7

ENV DANTE_VER=1.4.3 \
    IFACE=eth0 \
    WORKERS=1 \
    PORT=8118 \
    USER=dummyUser \
    PASS=dummyPass \
    EASZLAB_DANTE_TAG=1.4.3

RUN set -x \
 && yum update -y \
 && yum install -y \
      curl \
      gcc \
      iproute \
      make \
 && cd /tmp \
 && curl -L https://www.inet.no/dante/files/dante-$DANTE_VER.tar.gz | tar xz \
 && cd dante-* \
 && ./configure \
      --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --disable-client \
      --disable-pidfile \
      --without-libwrap \
      --without-bsdauth \
      --without-gssapi \
      --without-upnp \
      --without-pam \
 && make && make install \
 && cd / \
    # Add an unprivileged user.
 && adduser -r -M  -U -s /sbin/nologin sockd \
    # set timezone
 && cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    # Clean up.
 && rm -rf /tmp/* \
 && yum remove gcc make -y \
 && yum clean all \
 && rm -rf /var/cache/yum \
    # forward sockd logs to docker log collector.
 && ln -sf /dev/stdout /var/log/sockd.log

COPY sockd.conf start.sh ./

CMD ["./start.sh"]
