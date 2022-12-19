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
PANDOC_VERSION?=2.17.0.1
CROSSREF_VERSION?=0.3.12.2

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


##
##               H E L P
##

default:: help

help::  #: Display this message
	@echo
	@echo "Pandocker Makefile targets"
	@echo
	@gawk 'match($$0, /([^:]*):.+#'': (.*)/, m) { printf "    %-16s%s\n", m[1], m[2]}' $(MAKEFILE_LIST) | sort
	@echo


.PHONY: build
build:  ubuntu

.PHONY: stretch
stretch: stretch/Dockerfile
	docker build \
	    --build-arg APT_CACHER=$${APT_CACHER-} \
	    --build-arg PANDOC_VERSION=$(PANDOC_VERSION) \
	    --build-arg PANDOC_CROSSREF_VERSION=$(CROSSREF_VERSION) \
	    --tag $(NAME):$@-$(TAG) --file $^ .

.PHONY: ubuntu
ubuntu: ubuntu/Dockerfile #: Extra variant based on Ubuntu
	docker build --tag $(NAME):$@-$(TAG) --file $^ .

.PHONY: ubuntu-full
ubuntu-full: ubuntu-full/Dockerfile #: Full variant
	docker build --tag $(NAME):$@-$(TAG) --file $^ .


.PHONY: alpine
alpine: alpine/Dockerfile
	docker build --tag $(NAME):$@-$(TAG) --file $^ .

.PHONY: alpine-full
alpine-full: alpine-full/Dockerfile
	docker build --tag $(NAME):$@-$(TAG) --file $^ .

.PHONY: buster
buster: buster/Dockerfile
	docker build \
	    $(BUILD_OPT) \
	    --build-arg PANDOC_VERSION=$(PANDOC_VERSION) \
	    --build-arg CROSSREF_VERSION=$(CROSSREF_VERSION) \
	    --tag $(NAME):$@-$(TAG) \
	    --file $^ .

.PHONY: buster-full
buster-full: buster-full/Dockerfile
	docker build \
	    $(BUILD_OPT) \
	    --tag $(NAME):$@-$(TAG) \
	    --file $^ .

.PHONY: test
test:
	$(BATS) $(BATS_FILTER) tests/extra.bats

.PHONY: test-full
test-full:
	$(BATS) $(BATS_FILTER) tests/full.bats

authors:
	git shortlog -s -n

clean:
	find tests/output -type f -and -not -name .keep -delete
	docker rmi $(NAME):$(TAG)

warm-cache:
	./fetch-pandoc.sh $(PANDOC_VERSION) cache/pandoc.deb
	./fetch-pandoc-crossref.sh $(PANDOC_VERSION) $(PANDOC_CROSSREF_VERSION) cache/pandoc-crossref.tar.gz
	pip download --dest cache/ --requirement requirements.txt

alpine_sh alpine-full_sh: #: enter a docker image (useful for testing)
	docker run --rm -it --volume $(PWD):/pandoc --entrypoint=sh $(NAME):$(@:_bash=)-$(TAG)

buster_bash buster-full_bash: #: enter a docker image (useful for testing)
	docker run --rm -it --volume $(PWD):/pandoc --entrypoint=bash $(NAME):$(@:_bash=)-$(TAG)

ubuntu_bash ubuntu-full_bash: #: enter a docker image (useful for testing)
	docker run --rm -it --volume $(PWD):/pandoc --entrypoint=bash $(NAME):$(@:_bash=)-$(TAG)

