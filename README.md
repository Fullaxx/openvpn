# openvpn
Openvpn running in docker

## Base Docker Image
[Alpine](https://hub.docker.com/_/alpine) (x64)
[Debian](https://hub.docker.com/_/debian) (x64) Bookworm/Bullseye
[Ubuntu](https://hub.docker.com/_/ubuntu) (x64) Noble/Jammy

## Get the image from Docker Hub or Build it locally
```
docker pull fullaxx/openvpn:alpine
docker build -f dockerfiles/Dockerfile.alpine   -t="fullaxx/openvpn:alpine" github.com/Fullaxx/openvpn

docker pull fullaxx/openvpn:bookworm
docker build -f dockerfiles/Dockerfile.bookworm -t="fullaxx/openvpn:bookworm" github.com/Fullaxx/openvpn

docker pull fullaxx/openvpn:bullseye
docker build -f dockerfiles/Dockerfile.bullseye -t="fullaxx/openvpn:bullseye" github.com/Fullaxx/openvpn

docker pull fullaxx/openvpn:noble
docker build -f dockerfiles/Dockerfile.noble    -t="fullaxx/openvpn:noble" github.com/Fullaxx/openvpn

docker pull fullaxx/openvpn:jammy
docker build -f dockerfiles/Dockerfile.jammy    -t="fullaxx/openvpn:jammy" github.com/Fullaxx/openvpn
```
