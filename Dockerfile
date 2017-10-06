FROM gcr.io/google_containers/ubuntu-slim:0.14

LABEL maintainer="Jimmy Lu <gn00023040@gmail.com>"

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=144 \
    JAVA_VERSION_BUILD=01 \
    JAVA_PACKAGE=server-jre \
    JAVA_HOME=/opt/java \
    PATH=${PATH}:/opt/java/bin

RUN set -e \
    && apt-get update \
    && apt-get -qq -y --force-yes install --no-install-recommends curl unzip \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/090f390dda5b47b9b721c7dfaa008135/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    && gunzip /tmp/java.tar.gz \
    && tar -C /opt -xf /tmp/java.tar \
    && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} \
    && find "${JAVA_HOME}/" -maxdepth 1 -mindepth 1 | grep -v jre | xargs rm -rf \
    && cd ${JAVA_HOME} \
    && ln -s ./jre/bin ./bin \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
        http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cd /tmp \
    && unzip /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cp -v /tmp/UnlimitedJCEPolicyJDK8/*.jar ${JAVA_HOME}/jre/lib/security/ \
    && sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ ${JAVA_HOME}/jre/lib/security/java.security \
    && apt-get -y purge curl unzip \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf \
        /var/log/* \
        /tmp/* \
        ${JAVA_HOME}/jre/plugin \
        ${JAVA_HOME}/jre/bin/javaws \
        ${JAVA_HOME}/jre/bin/jjs \
        ${JAVA_HOME}/jre/bin/orbd \
        ${JAVA_HOME}/jre/bin/pack200 \
        ${JAVA_HOME}/jre/bin/policytool \
        ${JAVA_HOME}/jre/bin/rmid \
        ${JAVA_HOME}/jre/bin/rmiregistry \
        ${JAVA_HOME}/jre/bin/servertool \
        ${JAVA_HOME}/jre/bin/tnameserv \
        ${JAVA_HOME}/jre/bin/unpack200 \
        ${JAVA_HOME}/jre/lib/javaws.jar \
        ${JAVA_HOME}/jre/lib/deploy* \
        ${JAVA_HOME}/jre/lib/desktop \
        ${JAVA_HOME}/jre/lib/*javafx* \
        ${JAVA_HOME}/jre/lib/*jfx* \
        ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
        ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
        ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
        ${JAVA_HOME}/jre/lib/amd64/libglass.so \
        ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
        ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
        ${JAVA_HOME}/jre/lib/amd64/libjfx*.so \
        ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
        ${JAVA_HOME}/jre/lib/ext/nashorn.jar \
        ${JAVA_HOME}/jre/lib/oblique-fonts \
        ${JAVA_HOME}/jre/lib/plugin.jar \
        ${JAVA_HOME}/jre/COPYRIGHT \
        ${JAVA_HOME}/jre/LICENSE \
        ${JAVA_HOME}/jre/README \
        ${JAVA_HOME}/jre/THIRDPARTYLICENSEREADME.txt \
        ${JAVA_HOME}/jre/Welcome.html
