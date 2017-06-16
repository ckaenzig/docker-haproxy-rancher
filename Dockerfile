FROM haproxy:1.7

ENV \
  CONFD_VERSION=0.12.0-alpha3 \
  REFRESH_INTERVAL=10

RUN apt-get update \
  && apt-get install -y curl rsync \
  && rm -rf /var/apt/lists/*

RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 \
  && chmod +x /usr/local/bin/confd

ADD haproxy-reload.sh /usr/local/sbin/

COPY ./haproxy.d /haproxy.d

COPY ./conf.d /etc/confd/conf.d
COPY ./templates /etc/confd/templates

CMD /usr/local/bin/confd -interval $REFRESH_INTERVAL -config-file=/etc/confd/conf.d/$CONFD_CONFIG.cfg.toml -backend rancher -prefix /2016-07-29
