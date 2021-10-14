#!/usr/bin/env bash

TIME=$(date +%s)

# Compile
hugo

# Build
podman build -t docker.io/keloran/blog:$TIME --arch arm64 -f ./Dockerfile
podman build -t docker.io/keloran/blog:latest --arch arm64 -f ./Dockerfile

# Publish
podman push docker.io/keloran/blog:$TIME
podman push docker.io/keloran/blog:latest

# Deploy
kubectl set image deployment/blog blog=keloran/blog:$TIME --namespace k8s-blog