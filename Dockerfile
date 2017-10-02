FROM gcr.io/google_containers/ubuntu-slim:0.14

LABEL maintainer="Jimmy Lu <jimmylu@hyvesolutions.com>"

ENV JAVA_PKG=server-jre-8u*-linux-x64.tar.gz \
    JAVA_HOME=/usr/java/default \
    PATH=${PATH}:/usr/java/default/bin

ADD $JAVA_PKG /usr/lib/jvm

RUN set -e \
    && JAVA_DIR=$(ls -1 -d /usr/lib/jvm/*) \
    && mkdir -p /usr/java \
    && ln -s $JAVA_DIR /usr/java/latest \
    && ln -s $JAVA_DIR /usr/java/default \
    && rm -rf \
        /var/log/* \
        /tmp/*
