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
      psmisc \
      rsync \
      socat && \
    cd /root/down && rm -f systemd* && \
    tar zcvf /tmp/basic_centos7.tar.gz *.rpm && \
    rm -rf * && \
    yum install --downloadonly --downloaddir=/root/down chrony && \
    tar zcvf /tmp/chrony_centos7.tar.gz *.rpm && \
    rm -rf * && \
    yum install --downloadonly --downloaddir=/root/down haproxy && \
    tar zcvf /tmp/haproxy_centos7.tar.gz *.rpm && \
    rm -rf * && \
    yum install --downloadonly --downloaddir=/root/down keepalived && \
    tar zcvf /tmp/keepalived_centos7.tar.gz *.rpm

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
    tar zcvf /tmp/basic_xenial.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y chrony && \
    tar zcvf /tmp/chrony_xenial.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y haproxy && \
    tar zcvf /tmp/haproxy_xenial.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y keepalived && \
    tar zcvf /tmp/keepalived_xenial.tar.gz *.deb

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
    tar zcvf /tmp/basic_bionic.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y chrony && \
    tar zcvf /tmp/chrony_bionic.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y haproxy && \
    tar zcvf /tmp/haproxy_bionic.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y keepalived && \
    tar zcvf /tmp/keepalived_bionic.tar.gz *.deb

# 4.downloading deb packages on Debian9
FROM debian:9 as deb_stretch

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      psmisc \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_stretch.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y chrony && \
    tar zcvf /tmp/chrony_stretch.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y haproxy && \
    tar zcvf /tmp/haproxy_stretch.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y keepalived && \
    tar zcvf /tmp/keepalived_stretch.tar.gz *.deb

# 5.downloading deb packages on Debian10
FROM debian:10 as deb_buster

RUN apt update && \
    apt install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      psmisc \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/basic_buster.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y chrony && \
    tar zcvf /tmp/chrony_buster.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y haproxy && \
    tar zcvf /tmp/haproxy_buster.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y keepalived && \
    tar zcvf /tmp/keepalived_buster.tar.gz *.deb

# storing packages on alpine
FROM alpine:3.9

ENV SYS_PKG_VER=0.3.3

COPY --from=rpm_centos7 /tmp/*.tar.gz /packages/

COPY --from=deb_xenial /tmp/*.tar.gz /packages/

COPY --from=deb_bionic /tmp/*.tar.gz /packages/

COPY --from=deb_stretch /tmp/*.tar.gz /packages/

COPY --from=deb_buster /tmp/*.tar.gz /packages/

CMD [ "sleep", "360000000" ]
