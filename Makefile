IMAGE_TIME=$(shell date "+%Y-%m-%d_%H-%M")

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
	hugo
	podman build -t ghcr.io/keloran/blog:${IMAGE_TIME} --arch=arm64 -f ./Dockerfile
	podman tag ghcr.io/keloran/blog:${IMAGE_TIME} ghcr.io/keloran/blog:latest


.PHONY: publish-image
publish-image: podman-start
	podman push ghcr.io/keloran/blog:${IMAGE_TIME}
	podman push ghcr.io/keloran/blog:latest

.PHONY: deploy-image
deploy-image:
	kubectl set image deployment/blog blog=ghcr.io/keloran/blog:${IMAGE_TIME} --namespace k8s-blog

.PHONY: build
build: podman-start build-image podman-stop

.PHONY: deploy
deploy: podman-start publish-image podman-stop deploy-image 

.PHONY: build-deploy
build-deploy: podman-start build-image publish-image podman-stop deploy-image

.PHONY: new_project
new_project:
	hugo new -k current_projects current/$(project)

.PHONY: new_blog
new_blog:
	hugo new -k post post/$(title)