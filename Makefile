IMAGE_NAME := ckeyer/obc
SUF_TAG := -0621
CONTAINER_GOPATH := /go
PWD := $(shell pwd)

default:

build:
	docker build -f Dockerfile -t $(IMAGE_NAME):build$(SUF_TAG) .
	-mkdir bin
	docker run --rm \
	 --name buildover \
	 -v $(PWD)/:/tmp/bin \
	 $(IMAGE_NAME):build$(SUF_TAG) cp -a $(CONTAINER_GOPATH)/bin /tmp/bin
