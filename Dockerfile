FROM debian:buster

LABEL arch="armhf|armv7|aarch64|amd64|i386"

MAINTAINER Sébastien Piller <me@sebpiller.ch>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends default-jdk && \

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

COPY bin/luke-roberts-lamp-f-cli-LATEST.jar /

# Ok if able to call usage of the command
HEALTHCHECK CMD java -jar /luke-roberts-lamp-f-cli-LATEST.jar --help