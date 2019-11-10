# Dockerfile for building images to run kubeasz in a container
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz
# @ref:     https://github.com/easzlab/kubeasz
FROM alpine:3.9

ENV KUBEASZ_VER=2.1.0 \
    ANSIBLE_VER=2.6.18 \
    NETADDR_VER=0.7.19

RUN echo "===> Adding Python runtime..."                                    && \
    apk --update add python py-pip openssl ca-certificates                  && \
    apk --update add --virtual build-dependencies \
        python-dev libffi-dev openssl-dev build-base                        && \
    pip install --upgrade pip cffi                                          && \
    \
    echo "===> Installing Ansible/netaddr..."                               && \
    pip install ansible=="$ANSIBLE_VER" netaddr=="$NETADDR_VER"             && \
    \
    echo "===> Installing handy tools..."                                   && \
    pip install --upgrade pycrypto                                          && \
    apk --update add bash openssh-client rsync                              && \
    \
    echo "===> Downloading kubeasz..."                                      && \
    wget https://github.com/easzlab/kubeasz/archive/"$KUBEASZ_VER".tar.gz   && \
    tar zxf ./"$KUBEASZ_VER".tar.gz                                         && \
    mv kubeasz-"$KUBEASZ_VER" /etc/ansible                                  && \
    ln -s /etc/ansible/tools/easzctl /usr/bin/easzctl                       && \
    \
    echo "===> Removing package list..."                                    && \
    apk del build-dependencies                                              && \
    rm -rf /var/cache/apk/*                                                 && \
    rm -rf /root/.cache                                                     && \
    rm -rf ./"$KUBEASZ_VER".tar.gz

CMD [ "sleep", "360000000" ]
