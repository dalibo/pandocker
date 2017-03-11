

all: build

build: Dockerfile
	docker build .
