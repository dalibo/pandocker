# pandocker

[![Docker Image](https://images.microbadger.com/badges/image/dalibo/pandocker.svg)](https://hub.docker.com/r/dalibo/pandocker)
[![CI](https://circleci.com/gh/dalibo/pandocker.svg?style=shield)](https://circleci.com/gh/dalibo/pandocker)

A simple docker image for pandoc with filters, fonts, and the latex bazaar.

## How To

Run `dalibo/pandocker`  with regular `pandoc` args. Mount your files at `/pandoc`.

``` console
$ docker run --rm -v ${PWD}:/pandoc dalibo/pandocker README.md
```

Tip: use a shell alias to use `pandocker` just like `pandoc`. Add this to your `~/.bashrc` :

``` console
$ alias pandoc="docker run --rm -v `pwd`:/pandoc dalibo/pandocker"
$ pandoc document.md
```

Note: if SELinux is enabled on you system, you might need to add the
`--privileged` tag to force access to the mouting points. See
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities .


## Supported Tags

You can use 2 different versions of this machine using the following tags:

* `latest` : this is the default  (based on `master` branch)
* `stable` or `17.12`  : for production

## Deprecated Tags

The following versions are NOT supported anymore

* `17.09`, `jessie` : obsolete
* `no-entrypoint`  : formelly used for Gitlab-CI
* `devel` : abandonned


## Build it

Use `Makefile` or `docker` client:

```
make
```

or

```
docker build .
```
