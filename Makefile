GIT_COMMIT=`git rev-parse --short HEAD`
SERVICE_NAME=blog

.PHONY: server
server:
	hugo server -D

.PHONY: compile
compile:
	hugo

.PHONY: build-image
build-image: #compile
	nerdctl build --platform=linux/arm64,linux/amd64 --tag containers.chewed-k8s.net/keloran/blog:${GIT_COMMIT} -f ./Containerfile .
	nerdctl tag containers.chewed-k8s.net/keloran/blog:${GIT_COMMIT} containers.chewed-k8s.net/keloran/blog:latest

.PHONY: publish-latest-images
publish-latest-images:
	nerdctl push containers.chewed-k8s.net/keloran/blog:${GIT_COMMIT} --all-platforms
	nerdctl push containers.chewed-k8s.net/keloran/blog:latest --all-platforms

.PHONY: deploy-image
deploy-image:
	kubectl set image deployment/${SERVICE_NAME} ${SERVICE_NAME}=containers.chewed-k8s.net/keloran/blog:${GIT_COMMIT} --namespace keloran

.PHONY: build
build: build-image

.PHONY: deploy
deploy: publish-latest-images deploy-image

.PHONY: build-deploy
build-deploy: build-image publish-latest-images deploy-image

.PHONY: new_project
new_project:
	hugo new -k current_projects current/$(project).md

.PHONY: new_blog
new_blog:
	hugo new -k post post/$(title).md
