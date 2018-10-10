
IMAGE_VERSION=v0.1
IMAGE_NAME=base-image/hdf3.2
PARENT_DIR=$(shell basename "${PWD%/*}")
CURRENT_DIR="$(PWD##*/)"

.PHONY: build
build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
.PHONY: clean
clean:
	minishift docker-env
	minishift oc-env
	docker login -u developer -p "$(shell oc whoami -t)" $(shell minishift openshift registry)
	docker rmi $(IMAGE_NAME):$(IMAGE_VERSION)
test:
	oc new-app --docker-image=$(IMAGE_NAME):$(IMAGE_VERSION) --name=test$(RANDOM)
