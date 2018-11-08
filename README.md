# pandocker

[![github
release](https://img.shields.io/github/release/dalibo/pandocker.svg?label=current+release)](https://github.com/dalibo/pandocker/releases)
[![Docker Image](https://images.microbadger.com/badges/image/dalibo/pandocker.svg)](https://hub.docker.com/r/dalibo/pandocker)
[![CI](https://circleci.com/gh/dalibo/pandocker.svg?style=shield)](https://circleci.com/gh/dalibo/pandocker)
[![License](https://img.shields.io/github/license/dalibo/pandocker.svg)](https://github.com/dalibo/pandocker/blob/master/LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/dalibo/pandocker.svg)](https://github.com/dalibo/pandocker/branches)

A simple docker image for pandoc with filters, templates, fonts and the
latex bazaar.

## How To

Run `dalibo/pandocker`  with regular `pandoc` args. Mount your files at `/pandoc`.

``` console
$ docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker README.md
```

Tip: use a shell alias to use `pandocker` just like `pandoc`.
Add this to your `~/.bashrc` :

``` console
$ alias pandoc="docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker"
$ pandoc document.md
```

Note: if SELinux is enabled on you system, you might need to add the
`--privileged` tag to force access to the mouting points. See
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities .


## Supported Tags

You can use 2 different versions of this machine with the following tags:

* `latest` : this is the default  (based on `master` branch)
* `stable` or `17.12`  : for production

Other tags are not supported and should be used with care.


## Build it

Use `make` or `docker build`


## Embedded template : Eisvogel

We're shipping a latex template inside the image so that you can produce a
nice PDF without installing anything.  The template is called [eisvogel] and
you can use it simply by adding `--template=eisvogel` to your compilation
lines:

``` console
$ docker run [...] --pdf-engine=xelatex --template=eisvogel foo.md -o foo.pdf
```

[eisvogel]: https://github.com/Wandmalfarbe/pandoc-latex-template 