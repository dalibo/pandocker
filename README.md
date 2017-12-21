# pandocker

A simple docker for pandoc with filters, fonts, and the latex bazaar.

## How To

Run `dalibo/pandocker` image with regular `pandoc` args. Mount your files at `/pandoc`.

``` console
$ docker run --rm -v ${PWD}:/pandoc dalibo/pandocker document.md
```

Tip: use a shell alias to use `pandocker` just like `pandoc`. Add this to your `~/.bashrc` :

``` console
$ alias pandoc="docker run --rm -v `pwd`:/pandoc dalibo/pandocker"
$ pandoc document.md
```

Note: if SELinux is enabled on you system, you might need to add the
`--privileged` tag to force access to the mouting points. See
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities .


## Tags

You can use different versions of this machine using the following tags:

  * `latest`  : this is the default  (based on `master` branch)
  * `jessie`  : based on debian 8
  * `stretch` : based on debian 9
  * `devel`   : based on the upcoming ubuntu distro


## Build it

Use `Makefile` or `docker` client:

```
make
```

or 

```
docker build .
```
