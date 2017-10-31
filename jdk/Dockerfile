FROM gcr.io/google_containers/ubuntu-slim:0.14

LABEL maintainer="Jimmy Lu <gn00023040@gmail.com>"

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=152 \
    JAVA_VERSION_BUILD=16 \
    JAVA_PACKAGE=jdk \
    JAVA_SHA=aa0333dd3019491ca4f6ddbe78cdb6d0 \
    JAVA_HOME=/opt/java \
    PATH=${PATH}:/opt/java/bin \
    DI_VERSION=1.2.0 \
    DI_SHA=81231da1cd074fdc81af62789fead8641ef3f24b6b07366a1c34e5b059faf363

RUN set -e \
    && apt-get update \
    && apt-get -qq -y --force-yes install --no-install-recommends curl unzip ca-certificates \
    && curl -sLo /sbin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DI_VERSION}/dumb-init_${DI_VERSION}_amd64 \
    && echo "$DI_SHA  /sbin/dumb-init" | sha256sum -c - \
    && chmod +x /sbin/dumb-init \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_SHA}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    && tar zxf /tmp/java.tar.gz -C /opt \
    && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} \
    && cd ${JAVA_HOME} \
    && ln -s ./jre/bin ./bin \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
        http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cd /tmp \
    && unzip /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cp -v /tmp/UnlimitedJCEPolicyJDK8/*.jar ${JAVA_HOME}/jre/lib/security/ \
    && sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ ${JAVA_HOME}/jre/lib/security/java.security \
    && apt-get -y purge curl unzip ca-certificates \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf \
        /var/log/* \
        /tmp/* \
        ${JAVA_HOME}/*.txt \
        ${JAVA_HOME}/COPYRIGHT \
        ${JAVA_HOME}/LICENSE \
        ${JAVA_HOME}/release \
        ${JAVA_HOME}/README.html \
        ${JAVA_HOME}/src.zip \
        ${JAVA_HOME}/javafx-src.zip \
        ${JAVA_HOME}/man \
        ${JAVA_HOME}/include \
        ${JAVA_HOME}/jre/COPYRIGHT \
        ${JAVA_HOME}/jre/LICENSE \
        ${JAVA_HOME}/jre/README \
        ${JAVA_HOME}/jre/*.txt \
        ${JAVA_HOME}/jre/Welcome.html
