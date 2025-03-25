
# name of the image
NAME?=dalibo/pandocker

# By default, the tag is the git branch name
TAG?=$(shell git branch | grep -e "^*" | cut -d' ' -f 2)

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

all: extra full

.PHONY: extra
extra: Dockerfile
	docker build --tag $(NAME):$@-$(TAG) --file $^ . --target extra

.PHONY: full
full: Dockerfile
	docker build --tag $(NAME):$@-$(TAG) --file $^ . --target full

.PHONY: test
test: #: use `TEST_ONLY=571 make test` to trigger a single test !
	$(BATS) $(BATS_FILTER) tests/extra.bats

.PHONY: test-full
test-full:
	$(BATS) $(BATS_FILTER) tests/full.bats

authors:
	git shortlog -s -n

clean:
	find tests/output -type f -and -not -name .keep -delete
	docker rmi $(NAME):$(TAG)

ubuntu_bash ubuntu-full_bash: #: enter a docker image (useful for testing)
	docker run --rm -it --volume $(PWD):/pandoc --entrypoint=bash $(NAME):$(@:_bash=)-$(TAG)
