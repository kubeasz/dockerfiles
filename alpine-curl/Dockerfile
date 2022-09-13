# repo: easzlab/alpine-curl

FROM alpine:3.16

RUN set -x \
    && apk update \
       # Useful tools
    && apk --no-cache add \
        bash \
        curl \
       # Cleaning
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache

CMD [ "sleep", "360000000" ]
