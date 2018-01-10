NAME=dalibo/pandocker
TAG=latest

all: build

build: Dockerfile
	docker build --tag $(NAME):$(TAG) .
