ARG TARGETARCH
ARG TARGETPLATFORM
ARG BASE_BUILD=4.4.0
ARG PACKAGES=base

FROM ghcr.io/axoflow/axosyslog:${BASE_BUILD}

COPY packages/${PACKAGES}.list /work

# Set user and group
ARG user=segway
ARG group=segway
ARG uid=1000
ARG gid=1000
RUN apk add -U --upgrade --no-cache $(cat /work/${PACKAGES}.list);\
    rm /work/*.list ;\
    addgroup -g ${gid} ${group} ;\
    adduser -u ${uid} -D -G ${group} -s /bin/bash -h /home/${user} ${user}

# Switch to user
ENV SYSLOGNG_OPTS=--no-caps
ENV SEGWAY_SYSLOG_PORT=10514

COPY etc/syslog-ng/syslog-ng.conf /etc/syslog-ng
COPY etc/syslog-ng/conf.d /etc/syslog-ng/conf.d
