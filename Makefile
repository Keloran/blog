IMAGE_TIME=$(shell date "+%Y-%m-%d")

.PHONY: server
server:
	hugo server -D

.PHONY: podman-start
podman-start:
	podman machine stop
	sleep 10
	podman machine start

.PHONY: podman-stop
podman-stop:
	podman machine stop

.PHONY: build-image
build-image: 
	TIME=`date "+%Y-%m-%d"`
	hugo
	podman build -t ghcr.io/keloran/blog:${IMAGE_TIME} --arch=arm64 -f ./Dockerfile
	podman build -t ghcr.io/keloran/blog:latest --arch=arm64 -f ./Dockerfile


.PHONY: publish-image
publish-image: podman-start
	TIME=`date "+%Y-%m-%d"`
	podman push ghcr.io/keloran/blog:${IMAGE_TIME}
	podman push ghcr.io/keloran/blog:latest

.PHONY: deploy-image
deploy:
	TIME=`date "+%Y-%m-%d"`
	kubectl set image deployment/blog blog=ghcr.io/keloran/blog:${IMAGE_TIME} --namespace k8s-blog

.PHONY: build
build: podman-start build-image podman-stop

.PHONY: deploy
deploy: podman-start publish-image podman-stop deploy-image 
