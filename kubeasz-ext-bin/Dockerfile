# Download extral binaries needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-ext-bin
# @ref:     https://github.com/easzlab/kubeasz

FROM centos:7 as rpm_centos7

ENV NGINX_VERSION=1.18.0
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

ENV ETCD_VER=v3.4.13 \
    CNI_VER=v0.8.7 \
    HELM_VER=v3.4.2 \
    DOCKER_COMPOSE_VER=1.23.2 \
    CALICOCTL_VER=v3.15.3 \
    CRICTL_VER=v1.19.0 \
    RUNC_VER=v1.0.0-rc92 \
    CONTAINERD_VER=1.4.3 \
    EXT_BIN_VER=0.9.1

RUN mkdir -p /extra && \
    \
    wget https://github.com/etcd-io/etcd/releases/download/$ETCD_VER/etcd-$ETCD_VER-linux-amd64.tar.gz && \
    tar zxf etcd-$ETCD_VER-linux-amd64.tar.gz && \
    cd etcd-$ETCD_VER-linux-amd64 && \
    mv etcd etcdctl /extra && \
    cd / && rm -rf etcd-$ETCD_VER-linux-amd64* && \
    \
    wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 && \
    wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 && \
    wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64 && \
    mv cfssl_linux-amd64 /extra/cfssl && \
    mv cfssljson_linux-amd64 /extra/cfssljson && \
    mv cfssl-certinfo_linux-amd64 /extra/cfssl-certinfo && \
    \
    wget https://github.com/containernetworking/plugins/releases/download/$CNI_VER/cni-plugins-linux-amd64-$CNI_VER.tgz && \
    mkdir /cni && tar zxf cni-plugins-linux-amd64-$CNI_VER.tgz -C /cni && \
    cd /cni && mv bridge flannel host-local loopback portmap tuning /extra && \
    cd / && rm -rf cni* && \
    \
    wget https://get.helm.sh/helm-$HELM_VER-linux-amd64.tar.gz && \
    tar zxf helm-$HELM_VER-linux-amd64.tar.gz && \
    mv linux-amd64/helm /extra && \
    rm -rf linux-amd64 helm-$HELM_VER-linux-amd64.tar.gz && \
    \
    wget https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VER/docker-compose-Linux-x86_64 && \
    mv docker-compose-Linux-x86_64 /extra/docker-compose && \
    \
    wget https://github.com/projectcalico/calicoctl/releases/download/$CALICOCTL_VER/calicoctl-linux-amd64 && \
    mv calicoctl-linux-amd64 /extra/calicoctl && \
    \
    mkdir -p /extra/containerd-bin && \
    wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$CRICTL_VER/crictl-$CRICTL_VER-linux-amd64.tar.gz && \
    tar zxf crictl-$CRICTL_VER-linux-amd64.tar.gz -C /extra/containerd-bin && \
    wget https://github.com/opencontainers/runc/releases/download/$RUNC_VER/runc.amd64 && \
    chmod +x runc.amd64 && mv runc.amd64 /extra/containerd-bin/runc && \
    wget https://github.com/containerd/containerd/releases/download/v$CONTAINERD_VER/containerd-$CONTAINERD_VER-linux-amd64.tar.gz && \
    tar zxf containerd-$CONTAINERD_VER-linux-amd64.tar.gz -C /tmp && \
    mv /tmp/bin/* /extra/containerd-bin

COPY --from=rpm_centos7 /usr/local/nginx/sbin/nginx /extra
COPY --from=rpm_centos7 /usr/local/sbin/chronyd /extra
COPY --from=rpm_centos7 /usr/local/sbin/keepalived /extra

CMD [ "sleep", "360000000" ]
