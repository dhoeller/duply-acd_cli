FROM alpine:3.4

MAINTAINER dhoeller

RUN apk update \
    && apk upgrade \
    && apk add bash duply python3 fuse elinks wget ca-certificates \
    && wget -O- https://bootstrap.pypa.io/get-pip.py | python3 \
    && pip3 install acdcli \
    && rm -rf /root/.cache \
    && apk del wget ca-certificates \
    && rm /var/cache/apk/*

ENV LIBFUSE_PATH=/usr/lib/libfuse.so.2

ENV HOME /root

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
