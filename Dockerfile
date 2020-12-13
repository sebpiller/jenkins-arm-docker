FROM debian:buster
LABEL arch="armhf|armv7|aarch64|amd64|i386"
ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      wget curl software-properties-common gnupg2 git-all openjdk-11-jdk-headless maven binfmt-support qemu-user-static && \
    curl -fsSL --insecure https://download.docker.com/linux/debian/gpg | apt-key add - && \

    REL=$(lsb_release -cs) && \
    add-apt-repository "deb https://download.docker.com/linux/debian $REL stable" && \
    apt-get update -y && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \

    rm -rf /var/lib/apt/lists/* && \

    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -

# Copy Tomcat binaries
COPY bin/apache-tomcat-* /tomcat

# Delete default admin webapp
RUN rm -rf /tomcat/webapps/*

# Copy Jenkins binaries to tomcat webapps
COPY bin/jenkins-LATEST.war /tomcat/webapps/ROOT.war

COPY ./default-start.sh /default-start.sh
RUN chmod +x /default-start.sh

CMD [ "/bin/sh", "-c", "/default-start.sh && sleep infinity" ]