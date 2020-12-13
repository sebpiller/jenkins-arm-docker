FROM debian:buster
LABEL arch="armhf|armv7|aarch64|amd64|i386"
ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      wget curl software-properties-common gnupg2 git openjdk-11-jdk-headless maven && \

    curl -fsSL --insecure https://download.docker.com/linux/debian/gpg | apt-key add - && \
    REL=$(lsb_release -cs) && \
    add-apt-repository "deb https://download.docker.com/linux/debian $REL stable" && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      docker-ce docker-ce-cli containerd.io && \

    rm -rf /var/lib/apt/lists/* && \

    wget -O k3s https://github.com/k3s-io/k3s/releases/download/v1.19.5%2Bk3s1/k3s-armhf && \
    mv ./k3s /usr/local/bin/k3s && \
    chmod +x /usr/local/bin/k3s

# Copy Tomcat binaries
COPY bin/apache-tomcat-* /tomcat

# Delete default admin webapp
RUN rm -rf /tomcat/webapps/*

# Copy Jenkins binaries to tomcat webapps
COPY bin/jenkins-LATEST.war /tomcat/webapps/ROOT.war

COPY ./default-start.sh /default-start.sh
RUN chmod +x /default-start.sh

CMD [ "/bin/sh", "-c", "/default-start.sh && sleep infinity" ]