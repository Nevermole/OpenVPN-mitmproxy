FROM kylemanna/openvpn

ENV LANG=en_US.UTF-8

COPY docker-releases/alpine/requirements.txt requirements.txt /tmp/requirements.txt
RUN apk add --no-cache \
        git \
        g++ \
        libffi \
        libffi-dev \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        libstdc++ \
        libxml2 \
        libxml2-dev \
        libxslt \
        libxslt-dev \
        openssl \
        openssl-dev \
        python3 \
        python3-dev \
        zlib \
        zlib-dev \
    && python3 -m ensurepip \
    && LDFLAGS=-L/lib pip3 install -r /tmp/requirements.txt \
    && apk del --purge \
        git \
        g++ \
        libffi-dev \
        libjpeg-turbo-dev \
        libxml2-dev \
        libxslt-dev \
        openssl-dev \
        python3-dev \
        zlib-dev \
    && rm /tmp/requirements.txt \
    && rm -rf ~/.cache/pip 

#&& adduser -u 7799 -D mitmproxy

#USER mitmproxy
RUN mkdir /home/mitmproxy/.mitmproxy
VOLUME /home/mitmproxy/.mitmproxy

EXPOSE 8080 8081
EXPOSE 1194/udp
CMD ["ovpn_run", "mitmproxy"]
