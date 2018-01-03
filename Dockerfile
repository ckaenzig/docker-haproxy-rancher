FROM haproxy:1.8

ENV \
  CONFD_VERSION=0.14.0 \
  REFRESH_INTERVAL=300

RUN apt-get update \
  && apt-get install -y curl rsync \
  && rm -rf /var/apt/lists/*

RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 \
  && chmod +x /usr/local/bin/confd

ADD haproxy-reload.sh /usr/local/sbin/

COPY ./haproxy.d /haproxy.d
COPY ./confd /etc/confd

CMD /usr/local/bin/confd -interval $REFRESH_INTERVAL -confdir=/etc/confd/$HAPROXY_CONFD_TMPL/ -backend rancher -prefix /2016-07-29
