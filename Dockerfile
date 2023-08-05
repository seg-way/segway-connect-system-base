ARG SYSLOGNG_VERSION=4.3.1
FROM ghcr.io/axoflow/axosyslog:${SYSLOGNG_VERSION}

RUN apk add -U --upgrade --no-cache \
      openssl \
      py3-pip \
      python3 \
      tzdata \
      ca-certificates \
      poetry \
      cargo

ENV SYSLOGNG_OPTS=--no-caps
ENV SEGWAY_SYSLOG_PORT=10514

ENTRYPOINT ["/bin/entrypoint.sh"]

COPY bin/ /bin
COPY etc/syslog-ng/syslog-ng.conf /etc/syslog-ng
COPY etc/syslog-ng/conf.d /etc/syslog-ng/conf.d
