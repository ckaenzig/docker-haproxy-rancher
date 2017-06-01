FROM haproxy:1.7

ENV CONFD_VERSION=0.12.0-alpha3

RUN apt-get update \
  && apt-get install -y curl \
  && rm -rf /var/apt/lists/*

RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 \
  && chmod +x /usr/local/bin/confd

COPY ./conf.d /etc/confd/conf.d
COPY ./templates /etc/confd/templates

ENTRYPOINT ["/usr/local/bin/confd"]
CMD ["-interval", "3", "-backend", "rancher", "-prefix", "/2016-07-29"]
