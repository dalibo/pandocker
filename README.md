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

Note: when using the ["pandoc-include"](https://pypi.org/project/pandoc-include) filter to include other files, the working directory `pwd` to mount in docker *should* be a common parent directory of all referenced files to include. As `!include [mypath/myfile.md]` statements within markdown *should* be relative paths, the docker arg `--workdir="my/path/to/markdownfolder"` should be used to name the folder that the markdown file including the includes resides in. Full working example: `docker run --rm -v $(pwd):/pandoc --workdir="/pandoc/my/sub/folder/to-markdown-file" dalibo/pandocker --filter pandoc-include --pdf-engine=xelatex --template=eisvogel --listings --toc --toc-depth=3 ./myfile.md -o myfile-generated.pdf'`

## Supported Tags

You can use 2 different versions of this machine with the following tags:

* `latest` : this is the default  (based on `master` branch)
* `stable` or `17.12`  : for production

Other tags are not supported and should be used with care.


## Build it

Use `make` or `docker build .`


## Embedded template : Eisvogel

We're shipping a latex template inside the image so that you can produce a
nice PDF without installing anything.  The template is called [eisvogel] and
you can use it simply by adding `--template=eisvogel` to your compilation
lines:

``` console
$ docker run [...] --pdf-engine=xelatex --template=eisvogel foo.md -o foo.pdf
```

✋ W**Warning:** you need to remove the `-u` option when using [eisvogel].

[eisvogel]: https://github.com/Wandmalfarbe/pandoc-latex-template 
