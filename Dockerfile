FROM openjdk:8-jdk-alpine as builder

MAINTAINER René Fritze <rene.fritze@wwu.de>

RUN apk add --update-cache maven \
    && rm -rf /var/cache/apk/*

COPY veraPDF-apps /usr/local/src/
RUN cd /usr/local/src/ \
    && mvn clean install -DskipTests

FROM openjdk:8-jre-alpine

COPY --from=builder /usr/local/src/installer/target/verapdf-greenfield-*-installer.zip /tmp
COPY auto-install.xml /tmp
RUN apk add --update-cache unzip \
    && unzip /tmp/verapdf-greenfield-*-installer.zip -d /tmp \
    && /tmp/verapdf-greenfield-*/verapdf-install /tmp/auto-install.xml \
    && rm -rf /tmp/* \
    && verapdf --help
