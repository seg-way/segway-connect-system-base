ARG BASE_BUILD=4.4.0

FROM ghcr.io/axoflow/axosyslog:${BASE_BUILD}
ARG TARGETARCH
ARG TARGETPLATFORM
ARG PACKAGES=base

COPY packages/* /work/

# Set user and group
ARG user=segway
ARG group=segway
ARG uid=1000
ARG gid=1000
ENV SYSLOGNG_OPTS=--no-caps
ENV SEGWAY_SYSLOG_PORT=10514

RUN addgroup -g ${gid} ${group} ;\
    adduser -u ${uid} -D -G ${group} -s /bin/bash -h /home/${user} ${user}

COPY etc/syslog-ng/syslog-ng.conf /etc/syslog-ng
COPY etc/syslog-ng/conf.d /etc/syslog-ng/conf.d

# hadolint ignore=SC2046,DL3018
RUN apk add -U --upgrade --no-cache $(cat /work/${PACKAGES}.list)