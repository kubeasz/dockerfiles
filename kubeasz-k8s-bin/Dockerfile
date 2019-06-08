# Download kubernetes binaries needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-k8s-bin
# @ref:     https://github.com/easzlab/kubeasz

FROM alpine:3.9

ENV K8S_VER=v1.14.3

RUN wget https://dl.k8s.io/$K8S_VER/kubernetes-server-linux-amd64.tar.gz && \
    tar zxf kubernetes-server-linux-amd64.tar.gz && \
    cd kubernetes/server/bin && \
    mv kube-apiserver kube-controller-manager kube-scheduler /bin && \
    mv kubelet kube-proxy kubectl /bin && \
    cd / && rm -rf kubernetes*

CMD [ "sleep", "360000000" ]
