## make dalibo/pandocker

##
## V A R I A B L E S
##

# name of the image
NAME?=dalibo/pandocker

# By default, the tag is the git branch name
TAG?=$(shell git branch | grep -e "^*" | cut -d' ' -f 2)

# These versions must be changed together.
# See https://github.com/lierdakil/pandoc-crossref/releases to find the latest
# release corresponding to the desired Pandoc version.
PANDOC_VERSION?=2.9.1
PANDOC_CROSSREF_VERSION?=0.3.6.1a

# Bats
# We use bats-core instead of the original bats
BATS?=tests/libs/bats-core/bin/bats

# Bats filter
#
# usage : `TEST_ONLY=2 make test` will run all the tests starting with '2'.
#
TEST_ONLY?=
TEST_REGEXP?=
BATS_FILTER=

ifneq ($(TEST_ONLY),)
	BATS_FILTER:=--filter '^$(TEST_ONLY).*'
endif

# you can also pass a regexp directly
ifneq ($(TEST_REGEXP),)
	BATS_FILTER:=--filter '$(TEST_REGEXP)'
endif

##
## T A R G E T S
##
all: build

.PHONY: build
build:  stretch alpine alpine-full

.PHONY: stretch
stretch: Dockerfile
	docker build \
	    --build-arg APT_CACHER=$${APT_CACHER-} \
	    --build-arg PANDOC_VERSION=$(PANDOC_VERSION) \
	    --build-arg PANDOC_CROSSREF_VERSION=$(PANDOC_CROSSREF_VERSION) \
	    --tag $(NAME):$(TAG) .

.PHONY: alpine
alpine: alpine/Dockerfile
	docker build --tag $(NAME):$(TAG) --file $^ .

.PHONY: alpine-full
alpine-full: alpine-full/Dockerfile
	docker build --tag $(NAME):$(TAG) --file $^ .

.PHONY: buster
buster: buster/Dockerfile
	docker build --tag $(NAME):$(TAG) --file $^ .

.PHONY: test
test:
	$(BATS) $(BATS_FILTER) tests/docker.bats

authors:
	git shortlog -s -n

clean:
	docker rmi $(NAME):$(TAG)

warm-cache:
	./fetch-pandoc.sh $(PANDOC_VERSION) cache/pandoc.deb
	./fetch-pandoc-crossref.sh $(PANDOC_VERSION) $(PANDOC_CROSSREF_VERSION) cache/pandoc-crossref.tar.gz
	pip download --dest cache/ --requirement requirements.txt
