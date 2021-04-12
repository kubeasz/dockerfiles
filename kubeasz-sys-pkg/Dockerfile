# Download system packages (rpm or deb) needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-sys-pkg
# @ref:     https://github.com/easzlab/kubeasz

# 1.downloading rpm packages on CentOS7
FROM centos:7 as rpm_centos7

RUN yum install --downloadonly --downloaddir=/root/down \
      bash-completion \
      conntrack-tools \
      ipset \
      ipvsadm \
      libseccomp \
      nfs-utils \
      rsync \
      socat && \
    cd /root/down && rm -f systemd* && \
    tar zcvf /tmp/basic_centos7.tar.gz *.rpm

# 2.downloading deb packages on Ubuntu1604
FROM ubuntu:16.04 as deb_xenial

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_xenial.tar.gz *.deb

# 3.downloading deb packages on Ubuntu1804
FROM ubuntu:18.04 as deb_bionic

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_bionic.tar.gz *.deb

# 4.downloading deb packages on Ubuntu2004
FROM ubuntu:20.04 as deb_focal

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_focal.tar.gz *.deb

# 5.downloading deb packages on Debian9
FROM debian:9 as deb_stretch

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_stretch.tar.gz *.deb

# 6.downloading deb packages on Debian10
FROM debian:10 as deb_buster

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_buster.tar.gz *.deb

# storing packages on alpine
FROM alpine:3.12

ENV SYS_PKG_VER=0.4.1

COPY --from=rpm_centos7 /tmp/*.tar.gz /packages/

COPY --from=deb_xenial /tmp/*.tar.gz /packages/

COPY --from=deb_bionic /tmp/*.tar.gz /packages/

COPY --from=deb_focal /tmp/*.tar.gz /packages/

COPY --from=deb_stretch /tmp/*.tar.gz /packages/

COPY --from=deb_buster /tmp/*.tar.gz /packages/

CMD [ "sleep", "360000000" ]
