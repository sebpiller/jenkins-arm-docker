FROM debian:buster
LABEL arch="armhf|armv7|aarch64|amd64|i386"
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
ADD https://downloads.apache.org/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz .
ADD https://get.jenkins.io/war/2.276/jenkins.war .

RUN \
    tar -xvzf apache-tomcat-9.0.41.tar.gz && \
    mv apache-tomcat-9.0.41 /tomcat && \
    rm -rf /tomcat/webapps/* && \
    mv jenkins.war /tomcat/webapps/ROOT.war && \
    rm -rf /tmp/*

#RUN \
#    { printf "deb http://nexus.home/repository/debian_buster/ buster main\n"; printf "deb http://nexus.home/repository/debian-security_buster-updates/ buster/updates main\n"; printf "deb http://nexus.home/repository/debian_buster-updates/ buster-updates main\n\n"; } > /etc/apt/sources.list

RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      wget curl software-properties-common gnupg2 git  && \
      openjdk-14-jdk-headless maven && \
      npm nodejs && \

    curl -fsSL --insecure https://download.docker.com/linux/debian/gpg | apt-key add - && \
    REL=$(lsb_release -cs) && \
    add-apt-repository "deb http://nexus.home/repository/docker_buster/ $REL stable" && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      docker-ce docker-ce-cli containerd.io && \

    rm -rf /var/lib/apt/lists/* && \

    wget -O k3s https://github.com/k3s-io/k3s/releases/download/v1.19.5%2Bk3s1/k3s-armhf && \
    mv ./k3s /usr/local/bin/k3s && \
    chmod +x /usr/local/bin/k3s


COPY ./default-start.sh /default-start.sh
RUN chmod +x /default-start.sh

CMD [ "/bin/sh", "-c", "/default-start.sh && sleep infinity" ]