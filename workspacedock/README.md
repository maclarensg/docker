# Workspace Dock

## Description

A docker for creating openvpn tunnels to VPN without interfering host network connectivity


## Prequisite
sudo docker network inspect mynet1
sudo docker network create --subnet=192.168.88.0/24 mynet1

## Build 

```
cd workspace/build
sudo docker build -t workspacedock  .
```


## Run
```
sudo docker run --privileged --cap-add=NET_ADMIN --name=actility_workspace --hostname=workspace --network=mynet1 --ip=192.168.88.8 -i -t workspacedock
```
