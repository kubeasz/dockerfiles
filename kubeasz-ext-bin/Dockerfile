# Download extral binaries needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-ext-bin
# @ref:     https://github.com/easzlab/kubeasz

FROM alpine:3.9

ENV ETCD_VER=v3.4.13 \
    CNI_VER=v0.8.7 \
    HELM_VER=v3.4.2 \
    DOCKER_COMPOSE_VER=1.23.2 \
    CALICOCTL_VER=v3.15.3 \
    CRICTL_VER=v1.19.0 \
    RUNC_VER=v1.0.0-rc92 \
    CONTAINERD_VER=1.4.3 \
    EXT_BIN_VER=0.8.1
     
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

CMD [ "sleep", "360000000" ]
