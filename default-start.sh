echo "Starting docker..."
service docker start

echo "Starting tomcat..."
/tomcat/bin/catalina.sh run

#echo "Registering builder for multiarch"
#docker run --rm --privileged multiarch/qemu-user-static: --reset -p yes i
#docker buildx create --name multibuilder
#docker buildx inspect multibuilder --bootstrap
#docker buildx use multibuilder