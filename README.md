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

```console
$ docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker README.md
```

Tip: use a shell alias to use `pandocker` just like `pandoc`.
Add this to your `~/.bashrc` :

```console
$ alias pandoc="docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker"
$ pandoc document.md
```

Note: if SELinux is enabled on your system, you might need to add the
`--privileged` tag to force access to the mouting points. See
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities .

Alternatively, you can use pipes like this:

```console
$ cat foo.md | docker run --rm -i dalibo/pandocker --template=eisvogel -t pdf > foo.pdf
```

This method will not work if the source document contains images or includes...

## Templates

We're shipping a selection of latex templates inside the image so that you
can produce a nice PDF documents without installing anything.

So far, we provide the 2 templates below:

* [eisvogel] is designed for lecture notes and exercises with a focus on computer science.
* [letter] is for writing letters in markdown

You can use them simply by adding `--template=xxx` to your compilation
lines:

``` console
$ docker run [...] --pdf-engine=xelatex --template=eisvogel foo.md -o foo.pdf
```

Each template has specific variables that you can use to adapt the document.
Please go the project page of each template for more details.

✋ **Warning:** you need to remove the `-u` option when using the `--template`
option.

[eisvogel]: https://github.com/Wandmalfarbe/pandoc-latex-template
[letter]: https://github.com/aaronwolen/pandoc-letter

## Filters

This docker image embeds a number of usefull pandoc filters. You can simply enable them
by adding the option `--filter xxx` where `xxx` is the name of one of the following
filter below:

* [pandoc-citeproc]: manage bibliographies and citations
* [pandoc-codeblock-include]: insert an external file into a codeblock
* [pandoc-include] : insert external markdown files into the main document
* [pandoc-latex-admonition] : adding admonitions on specific DIVs
* [pandoc-latex-environment] : adding LaTeX environments on specific DIVs
* [pandoc-latex-barcode] : insert barcodes and QRcodes in documents
* [pandoc-mustache] : basic variables substitution
* [pandoc-minted] : advanced syntax highlighting
* [pandoc-crossref] : support for cross-referencing sections, figures, and more

NOTE: By default when using the [pandoc-include] filter, the path to target
files is relative to the `/pandoc` mountpoint. For instance,
the `!include [foo/bar.md]` statement will look for a `/pandoc/foo/bar.md` file.
You can use the docker arg `--workdir="some/place/elsewhere"` to specify
another location.

[pandoc-citeproc]: https://pandoc.org/demo/example19/Extension-citations.html
[pandoc-codeblock-include]: https://github.com/chdemko/pandoc-codeblock-include
[pandoc-include]: https://github.com/DCsunset/pandoc-include
[pandoc-latex-admonition]: https://github.com/chdemko/pandoc-latex-admonition
[pandoc-latex-environment]: https://github.com/chdemko/pandoc-latex-environment
[pandoc-latex-barcode]: https://github.com/daamien/pandoc-latex-barcode
[pandoc-mustache]: https://github.com/michaelstepner/pandoc-mustache
[pandoc-minted]: https://github.com/nick-ulle/pandoc-minted
[pandoc-crossref]: https://github.com/lierdakil/pandoc-crossref

## Fonts

The pandocker image includes the following open-source fonts:

* Deja Vu: https://dejavu-fonts.github.io/
* Lato: https://fonts.google.com/specimen/Lato
* Liberation: https://github.com/liberationfonts/liberation-fonts
* Noto: https://www.google.com/get/noto/

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

✋ **Warning:** you need to remove the `-u` option when using [eisvogel].

[eisvogel]: https://github.com/Wandmalfarbe/pandoc-latex-template

## Additional tools

The docker image embeds additional software related to editing and publishing:

* [dia] a simple tool to design diagrams
* [poppler-utils] a collection of tools built to manage PDF and extract content
* [rsync] for deployment

[dia]: http://dia-installer.de/
[poppler-utils]: https://en.wikipedia.org/wiki/Poppler_(software)#poppler-utils
[rsync]: https://rsync.samba.org/documentation.html

These tools can be used by modifying the entrypoint of the image. For instance,
you can convert a `dia` source file into an SVG image like this:

``` console
$ docker run [..] --entrypoint dia dalibo/pandocker foo.dia -e foo.svg
```
