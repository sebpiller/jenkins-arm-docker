# Start Tomcat with Jenkins
/tomcat/bin/catalina.sh run

# Start docker and load qemu-user-static for cross platform compilation
service docker start
docker run --rm --privileged multiarch/qemu-user-static: --reset -p yes i
docker buildx create --name multibuilder
docker buildx inspect multibuilder --bootstrap
docker buildx use multibuilder