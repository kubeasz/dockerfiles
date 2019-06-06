# Dockerfile for building images to run kubeasz in a container
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz
# @ref:     https://github.com/easzlab/kubeasz

FROM easzlab/ansible:2.6.12

ENV KUBEASZ_VER=1.2.0

RUN wget https://github.com/easzlab/kubeasz/archive/$KUBEASZ_VER.tar.gz && \
    tar zxf $KUBEASZ_VER* && \
    mv kubeasz-$KUBEASZ_VER /etc/ansible && \
    ln -s /etc/ansible/tools/easzctl /usr/bin/easzctl && \
    rm -f $KUBEASZ_VER*

CMD [ "sleep", "360000000" ]
