# Dockerfile for building images to run kubeasz in a container
#
# @author:  gjmzj
# @repo:     https://github.com/easzlab/kubeasz

FROM easzlab/ansible:2.10.6-lite

ENV KUBEASZ_VER=3.4.0

RUN set -x \
      # Downloading kubeasz
    && wget https://github.com/easzlab/kubeasz/archive/refs/tags/"$KUBEASZ_VER".tar.gz \
    && tar zxf ./"$KUBEASZ_VER".tar.gz \
    && mv kubeasz-"$KUBEASZ_VER" /etc/kubeasz \
    && ln -s -f /etc/kubeasz/ezctl /usr/bin/ezctl \
    && ln -s -f /etc/kubeasz/ezdown /usr/bin/ezdown \
      # Cleaning
    && rm -rf ./"$KUBEASZ_VER".tar.gz
