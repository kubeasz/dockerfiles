FROM ubuntu:18.04
LABEL Description="This is the image for testing nodejs"

# Install node
ARG NODE_VER=v14.17.0
ARG NODE_REPO=https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.xz

RUN apt-get update && apt-get install -y -q --no-install-recommends ca-certificates wget xz-utils

RUN wget ${NODE_REPO} && \
    tar xf node-${NODE_VER}-linux-x64.tar.xz && \
    cp node-*/* /usr/local -rf && rm -rf node-* && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*
