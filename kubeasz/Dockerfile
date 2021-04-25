# Dockerfile for building images to run kubeasz in a container
#
# @author:  gjmzj
# @repo:     https://github.com/easzlab/kubeasz

FROM easzlab/ansible:2.10.6-lite

ENV KUBEASZ_VER=3.1.0

RUN set -x \
      # Downloading kubeasz
    && wget https://github.com/easzlab/kubeasz/archive/"$KUBEASZ_VER".tar.gz \
    && tar zxf ./"$KUBEASZ_VER".tar.gz \
    && mv kubeasz-"$KUBEASZ_VER" /etc/kubeasz \
    && ln -s /etc/kubeasz/ezctl /usr/bin/ezctl \
    && ln -s /etc/kubeasz/ezdown /usr/bin/ezdown \
      # Cleaning
    && rm -rf ./"$KUBEASZ_VER".tar.gz
