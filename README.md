# jenkins-arm-docker

A docker image containing Java/JDK, Tomcat, Maven, Git, Docker, and k3s (Kubernetes client for ARM), compatible with ARM processors (eg. Raspberry Pi)

1) Run "fetch-binaries.\[sh|bat]" to get the latest binaries versions of Tomcat and Jenkins.
2) Run "build.\[sh|bat]" to build and push the image to your docker repository.


## Troubleshoot

If you get "Unknown desc = failed to load LLB: runtime execution on platform linux/arm/v7 not supported"

call:

```
sudo apt-get install qemu-user-static -y

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes i

docker buildx rm multibuilder
docker buildx create --name multibuilder
docker buildx ls
docker buildx inspect multibuilder
docker buildx inspect multibuilder --bootstrap
docker buildx use multibuilder
docker ps -a

# docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t <youruserid>/hello --push .
```
