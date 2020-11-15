FROM debian:buster

LABEL arch="armhf|armv7|aarch64|amd64|i386"

MAINTAINER Sébastien Piller <me@sebpiller.ch>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends git-all openjdk-11-jdk-headless maven

# Copy Tomcat binaries
COPY bin/apache-tomcat-* /tomcat

# Copy Jenkins binaries to tomcat webapps
COPY bin/jenkins-LATEST.war /tomcat/webapps/jenkins.war

CMD [ "/tomcat/bin/catalina.sh", "run"e ]