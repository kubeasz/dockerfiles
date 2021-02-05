# Download harbor offline-package needed by 'kubeasz'
#
# @author:  gjmzj
# @repo:    https://github.com/kubeasz/dockerfiles/harbor-offline
# @ref:     https://github.com/easzlab/kubeasz

FROM alpine:3.9

ENV HARBOR_VER=v2.1.3

RUN wget https://github.com/goharbor/harbor/releases/download/${HARBOR_VER}/harbor-offline-installer-${HARBOR_VER}.tgz

CMD [ "sleep", "360000000" ]
