# OpenVPN
OpenVPN running in docker

## Base Docker Image
[Alpine](https://hub.docker.com/_/alpine) (x64) \
[Debian](https://hub.docker.com/_/debian) (x64) Bookworm/Bullseye \
[Ubuntu](https://hub.docker.com/_/ubuntu) (x64) Noble/Jammy

## Software
[OpenVPN](https://openvpn.net/) - VPN software

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

## Required Volume Mount
This image requires 1 volume mount, a directory of profiles mounted on /profiles inside the container.
If you want OpenVPN to use a specific profile, use -e CONFIGFILE=myprofile.ovpn and that config file will be located under /profiles and passed to OpenVPN.
When that connection gets closed, the container will exit.
If you do not specify a config file the image will use the roundrobin.py script to cycle through all profiles indefinitely.
```
-v /srv/docker/openvpn/profiles/:/profiles:ro
```

## Environment Variables
* CONFIGFILE will specify a single one-time connection with a specific profile
* RANDOMIZE_PROFILE_LIST will randomize the profile list when using roundrobin mode
* ENABLEMASQ will enable masquarade through the tun device that OpenVPN creates
```
-e CONFIGFILE=myprofile.ovpn
-e RANDOMIZE_PROFILE_LIST=1
-e ENABLEMASQ=1
```

## OpenVPN routing
If you want to use OpenVPN as a masquarading router, use -e ENABLEMASQ=1.
This will enable the iptables commands to masquarade through the tun device.
Additionaly it will check to make sure that /proc/sys/net/ipv4/ip_forward is set to 1.
Use --sysctl net.ipv4.ip_forward=1 or see the compose example.

## Manually cycle to next profile
When using roundrobin mode, this command will disconnect from the current connection and jump to the next one in the list.
```
docker exec -it <CONTAINER> /app/cycle.sh
```

## Logging
Currently all logging is done through stdout/stderr.
```
docker logs -f <CONTAINER>
```

## Debugging
```
docker exec -it <CONTAINER> /app/debug.sh
```

## Alternatives
* [dperson/openvpn-client](https://github.com/dperson/openvpn-client)
* [qdm12/gluetun](https://github.com/qdm12/gluetun)
