NAME=dalibo/pandocker
TAG=latest

all: build

build: Dockerfile
	docker build --build-arg APT_CACHER=$${APT_CACHER-} --tag $(NAME):$(TAG) .

clean:
	docker rmi $(NAME):$(TAG)
