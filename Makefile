NAME?=dalibo/pandocker
TAG?=$(shell git branch | grep -e "^*" | cut -d' ' -f 2)
PANDOC_VERSION?=2.7

all: build

build: Dockerfile
	echo $(TAG)
	docker build \
	    --build-arg APT_CACHER=$${APT_CACHER-} \
	    --build-arg PANDOC_VERSION=$(PANDOC_VERSION) \
	    --tag $(NAME):$(TAG) .

test:
	tests/test.sh $(TAG)

authors:
	git shortlog -s -n

clean:
	docker rmi $(NAME):$(TAG)

warm-cache:
	./fetch-pandoc.sh $(PANDOC_VERSION) cache/pandoc.deb
	pip download --dest cache/ --requirement requirements.txt
