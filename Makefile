NAME?=dalibo/pandocker
TAG?=$(shell git branch | grep -e "^*" | cut -d' ' -f 2)

# These versions must be changed together.
# See https://github.com/lierdakil/pandoc-crossref/releases to find the latest
# release corresponding to the desired Pandoc version.
PANDOC_VERSION?=2.9
PANDOC_CROSSREF_VERSION?=0.3.6.0

all: build

build: Dockerfile
	echo $(TAG)
	docker build \
	    --build-arg APT_CACHER=$${APT_CACHER-} \
	    --build-arg PANDOC_VERSION=$(PANDOC_VERSION) \
	    --build-arg PANDOC_CROSSREF_VERSION=$(PANDOC_CROSSREF_VERSION) \
	    --tag $(NAME):$(TAG) .

test:
	tests/test.sh $(TAG)

authors:
	git shortlog -s -n

clean:
	docker rmi $(NAME):$(TAG)

warm-cache:
	./fetch-pandoc.sh $(PANDOC_VERSION) cache/pandoc.deb
	./fetch-pandoc-crossref.sh $(PANDOC_VERSION) $(PANDOC_CROSSREF_VERSION) cache/pandoc-crossref.tar.gz
	pip download --dest cache/ --requirement requirements.txt
