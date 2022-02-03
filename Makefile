GIT_COMMIT=`git rev-parse HEAD`

.PHONY: server
server:
	hugo server -D

.PHONY: build-push-image
build-push-image: 
	hugo
	nerdctl build --platform arm64,amd64 --output type=image,name=containers.home.develbox.info/keloran/blog:latest,push=true .

.PHONY: publish-image
publish-image: 
	nerdctl push containers.home.develbox.info/keloran/blog:${GIT_COMMIT}
	nerdctl push containers.home.develbox.info/keloran/blog:latest

.PHONY: deploy-image
deploy-image:
	kubectl set image deployment/blog blog=containers.home.develbox.info/keloran/blog:latest --namespace k8s-blog

.PHONY: build
build: build-image

.PHONY: deploy
deploy: publish-image deploy-image 

.PHONY: build-deploy
build-deploy: build-push-image deploy-image

.PHONY: new_project
new_project:
	hugo new -k current_projects current/$(project)

.PHONY: new_blog
new_blog:
	hugo new -k post post/$(title)