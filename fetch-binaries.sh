rm -rf bin/*
mkdir bin
cd bin
wget -O tomcat.tar.gz "https://downloads.apache.org/tomcat/tomcat-9/v9.0.39/bin/apache-tomcat-9.0.39.tar.gz" && tar -xvzf tomcat.tar.gz
wget -O jenkins-LATEST.war "https://get.jenkins.io/war/latest/jenkins.war"
