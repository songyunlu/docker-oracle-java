FROM gcr.io/google_containers/ubuntu-slim:0.14

LABEL maintainer="Jimmy Lu <gn00023040@gmail.com>"

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=144 \
    JAVA_VERSION_BUILD=01 \
    JAVA_PACKAGE=server-jre \
    JAVA_JCE=unlimited \
    JAVA_HOME=/opt/java \
    PATH=${PATH}:/opt/java/bin \
    LANG=C.UTF-8

RUN set -e \
    && apt-get update \
    && apt-get -qq -y --force-yes install --no-install-recommends curl unzip \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/090f390dda5b47b9b721c7dfaa008135/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    && gunzip /tmp/java.tar.gz \
    && tar -C /opt -xf /tmp/java.tar \
    && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/java \
    && find /opt/java/ -maxdepth 1 -mindepth 1 | grep -v jre | xargs rm -rf \
    && cd /opt/java \
    && ln -s ./jre/bin ./bin \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
        http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cd /tmp \
    && unzip /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cp -v /tmp/UnlimitedJCEPolicyJDK8/*.jar /opt/java/jre/lib/security/ \
    && sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ /opt/java/jre/lib/security/java.security \
    && apt-get -y purge curl unzip \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf \
        /var/log/* \
        /tmp/* \
        /opt/java/jre/plugin \
        /opt/java/jre/bin/javaws \
        /opt/java/jre/bin/jjs \
        /opt/java/jre/bin/orbd \
        /opt/java/jre/bin/pack200 \
        /opt/java/jre/bin/policytool \
        /opt/java/jre/bin/rmid \
        /opt/java/jre/bin/rmiregistry \
        /opt/java/jre/bin/servertool \
        /opt/java/jre/bin/tnameserv \
        /opt/java/jre/bin/unpack200 \
        /opt/java/jre/lib/javaws.jar \
        /opt/java/jre/lib/deploy* \
        /opt/java/jre/lib/desktop \
        /opt/java/jre/lib/*javafx* \
        /opt/java/jre/lib/*jfx* \
        /opt/java/jre/lib/amd64/libdecora_sse.so \
        /opt/java/jre/lib/amd64/libprism_*.so \
        /opt/java/jre/lib/amd64/libfxplugins.so \
        /opt/java/jre/lib/amd64/libglass.so \
        /opt/java/jre/lib/amd64/libgstreamer-lite.so \
        /opt/java/jre/lib/amd64/libjavafx*.so \
        /opt/java/jre/lib/amd64/libjfx*.so \
        /opt/java/jre/lib/ext/jfxrt.jar \
        /opt/java/jre/lib/ext/nashorn.jar \
        /opt/java/jre/lib/oblique-fonts \
        /opt/java/jre/lib/plugin.jar \
        /opt/java/jre/COPYRIGHT \
        /opt/java/jre/LICENSE \
        /opt/java/jre/README \
        /opt/java/jre/THIRDPARTYLICENSEREADME.txt \
        /opt/java/jre/Welcome.html
