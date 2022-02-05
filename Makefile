GIT_COMMIT=`git rev-parse --short HEAD`

.PHONY: server
server:
	hugo server -D

.PHONY: compile
compile:
	hugo

.PHONY: build-image
build-image: compile
	nerdctl build --platform=linux/arm64,linux/amd64 --tag containers.home.develbox.info/keloran/blog:${GIT_COMMIT} .
	nerdctl tag containers.home.develbox.info/keloran/blog:${GIT_COMMIT} containers.home.develbox.info/keloran/blog:latest
	nerdctl build --platform=linux/arm64,linux/amd64 --output type=image,name=containers.home.develbox.info/keloran/blog:${GIT_COMMIT}-push,push=true .

.PHONY: publish-latest-images
publish-latest-images:
	nerdctl push containers.home.develbox.info/keloran/blog:${GIT_COMMIT} --all-platforms
	nerdctl push containers.home.develbox.info/keloran/blog:latest --all-platforms

.PHONY: deploy-image
deploy-image:
	kubectl set image deployment/blog blog=containers.home.develbox.info/keloran/blog:${GIT_COMMIT} --namespace k8s-blog
	#kubectl set image deployment/blog blog=containers.home.develbox.info/keloran/blog:${GIT_COMMIT}-push --namespace k8s-blog

.PHONY: build
build: build-image

.PHONY: deploy
deploy: publish-image deploy-image 

.PHONY: build-deploy
build-deploy: build-image publish-latest-images deploy-image

.PHONY: new_project
new_project:
	hugo new -k current_projects current/$(project).md

.PHONY: new_blog
new_blog:
	hugo new -k post post/$(title).md