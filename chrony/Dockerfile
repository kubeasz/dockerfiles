# chrony dockerfile
# @usage:   docker run -d -p123:123/udp -v /your_chrony.conf:/etc/chrony/chrony.conf easzlab/chrony:$TAG
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/chrony
# @ref:     https://github.com/easzlab/kubeasz

FROM alpine:3.9

RUN apk --update add chrony && \
    rm -rf /var/cache/apk/*

EXPOSE 123/udp

HEALTHCHECK --interval=30s --timeout=5s CMD chronyc tracking > /dev/null

CMD ["/usr/sbin/chronyd", "-4", "-d", "-s"]
