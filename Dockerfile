FROM ghcr.io/axoflow/axosyslog:4.3.1

RUN apk update ;apk add -U --upgrade --no-cache \
      openssl \
      py3-pip \
      python3 \
      tzdata \
      ca-certificates \
      poetry \
      cargo \
      jq ;\
      poetry config virtualenvs.create false

ENV SYSLOGNG_OPTS=--no-caps
ENV SEGWAY_SYSLOG_PORT=10514

COPY etc/syslog-ng/syslog-ng.conf /etc/syslog-ng
COPY etc/syslog-ng/conf.d /etc/syslog-ng/conf.d
