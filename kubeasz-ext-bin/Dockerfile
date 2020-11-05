# Download extral binaries needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-ext-bin
# @ref:     https://github.com/easzlab/kubeasz

FROM alpine:3.9

ENV ETCD_VER=v3.4.13 \
    CNI_VER=v0.8.7 \
    HELM_VER=v3.2.4 \
    DOCKER_COMPOSE_VER=1.23.2 \
    CALICOCTL_VER=v3.8.8 \
    EXT_BIN_VER=0.6.0
     
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
    mv calicoctl-linux-amd64 /extra/calicoctl

CMD [ "sleep", "360000000" ]
