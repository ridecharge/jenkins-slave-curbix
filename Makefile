DOCKER_REPO?=registry.gocurb.internal:80
CONTAINER=$(DOCKER_REPO)/jenkins-slave-curbix

all: build run cleanup

build:  
	ansible-galaxy install -r requirements.yml -f
	docker build --no-cache -t $(CONTAINER):latest .

run:
	docker run $(CONTAINER):latest

packer:
	packer build -only=ubuntu14lts aws.json

cleanup:
	docker rmi -f $(CONTAINER)
	rm -r roles