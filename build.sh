#!/usr/bin/env bash

TIME=`date "+%s"`

# Podman Stuff
pmn=$(podman machine list | wc -l)

if [[ $pwn -eq 1 ]]; then
  podman machine start
else
  podman machine stop
  sleep 30
  podman machine start
fi

# Compile
hugo

# Build x86
#podman build -t docker.io/keloran/blog:$TIME --arch=amd64 -f ./Dockerfile
#podman build -t docker.io/keloran/blog:latest --arch=amd64 -f ./Dockerfile

# Build ARM
podman build -t docker.io/keloran/blog:$TIME --arch=arm64 -f ./Dockerfile
podman build -t docker.io/keloran/blog:latest --arch=arm64 -f ./Dockerfile

# Publish
podman push docker.io/keloran/blog:$TIME
podman push docker.io/keloran/blog:latest

# Deploy
kubectl set image deployment/blog blog=keloran/blog:$TIME --namespace k8s-blog

# Podman Stop
podman machine stop
