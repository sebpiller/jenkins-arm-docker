FROM debian:buster
LABEL arch="arm|arm64"
ENV DEBIAN_FRONTEND=noninteractive

ARG tcversion=9.0.44
ARG jenkinsversion=2.283
ARG k3sversion=1.20.4%2Bk3s1

ARG tomcat=https://downloads.apache.org/tomcat/tomcat-9/v$tcversion/bin/apache-tomcat-$tcversion.tar.gz
ARG jenkins=https://get.jenkins.io/war/$jenkinsversion/jenkins.war

# ARG dockerrepo=http://nexus.home/repository/docker_buster/
ARG dockerrepo=https://download.docker.com/linux/debian/dists/buster/

ADD $tomcat .
ADD $jenkins .

RUN \
    ls -lah && \
    tar -xvzf apache-tomcat-$tcversion.tar.gz && \
    mv apache-tomcat-$tcversion /tomcat && \
    rm -rf /tomcat/webapps/* && \
    mv jenkins.war /tomcat/webapps/ROOT.war && \
    rm -rf /tmp/*

#RUN \
#    { printf "deb http://nexus.home/repository/debian_buster/ buster main\n"; printf "deb http://nexus.home/repository/debian-security_buster-updates/ buster/updates main\n"; printf "deb http://nexus.home/repository/debian_buster-updates/ buster-updates main\n\n"; } > /etc/apt/sources.list

RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      wget curl software-properties-common gnupg2 git \
      openjdk-11-jdk-headless maven \
      npm nodejs && \

    curl -fsSL --insecure https://download.docker.com/linux/debian/gpg | apt-key add - && \

    REL=$(lsb_release -cs) && \
    add-apt-repository "deb $dockerrepo $REL stable" && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      docker-ce docker-ce-cli containerd.io && \

    rm -rf /var/lib/apt/lists/* && \

    wget -O k3s https://github.com/k3s-io/k3s/releases/download/v$k3sversion/k3s-armhf && \
    mv ./k3s /usr/local/bin/k3s && \
    chmod +x /usr/local/bin/k3s


COPY ./default-start.sh /default-start.sh
RUN chmod +x /default-start.sh

CMD [ "/bin/sh", "-c", "/default-start.sh && sleep infinity" ]