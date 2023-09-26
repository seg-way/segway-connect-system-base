FROM ghcr.io/axoflow/axosyslog:4.4.0

RUN apk add -U --upgrade --no-cache \
      bash \
      shadow \
      python3 \
      py3-pip \
      poetry \
      openssl \
      tzdata \
      ca-certificates \
      cargo \
      jq

# Set user and group
ARG user=segway
ARG group=segway
ARG uid=1000
ARG gid=1000
RUN addgroup -g ${gid} ${group} ;\
    adduser -u ${uid} -D -G ${group} -s /bin/bash -h /home/${user} ${user}

# Switch to user
ENV SYSLOGNG_OPTS=--no-caps
ENV SEGWAY_SYSLOG_PORT=10514

COPY etc/syslog-ng/syslog-ng.conf /etc/syslog-ng
COPY etc/syslog-ng/conf.d /etc/syslog-ng/conf.d
