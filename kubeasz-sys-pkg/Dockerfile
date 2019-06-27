# Download system packages (rpm or deb) needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/kubeasz-sys-pkg
# @ref:     https://github.com/easzlab/kubeasz

# 1.downloading rpm packages on CentOS7
FROM centos:7 as rpm_centos7

RUN yum install --downloadonly --downloaddir=/root/down \
      conntrack-tools \
      ipset \
      ipvsadm \
      libseccomp \
      nfs-utils \
      psmisc \
      rsync \
      socat && \
    cd /root/down && \
    tar zcvf /tmp/rpm_centos7.tar.gz *.rpm && \
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

RUN apt-get update && \
    apt-get install -d -y \
      conntrack \
      ipset \
      ipvsadm \
      jq \
      libseccomp2 \
      nfs-common \
      rsync \
      socat && \
    cd /var/cache/apt/archives && \
    tar zcvf /tmp/deb_xenial.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y chrony && \
    tar zcvf /tmp/chrony_xenial.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y haproxy && \
    tar zcvf /tmp/haproxy_xenial.tar.gz *.deb && \
    rm -rf * && \
    apt-get install -d -y keepalived && \
    tar zcvf /tmp/keepalived_xenial.tar.gz *.deb

# storing packages on alpine
FROM alpine:3.9

COPY --from=rpm_centos7 /tmp/*.tar.gz /tmp/

COPY --from=deb_xenial /tmp/*.tar.gz /tmp/

CMD [ "sleep", "360000000" ]
