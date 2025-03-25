# pandocker

[![github
release](https://img.shields.io/github/release/dalibo/pandocker.svg?label=current+release)](https://github.com/dalibo/pandocker/releases)
[![Docker Image](https://img.shields.io/docker/automated/dalibo/pandocker.svg)](https://hub.docker.com/r/dalibo/pandocker)
[![CI](https://github.com/dalibo/pandocker/actions/workflows/build.yml/badge.svg?branch=latest)](https://github.com/dalibo/pandocker/actions/workflows/build.yml)
[![Last Commit](https://img.shields.io/github/last-commit/dalibo/pandocker.svg)](https://github.com/dalibo/pandocker/branches)

A simple docker image for pandoc with [filters], [templates], [fonts] and
[additional tools].

[filters]: #filters
[templates]: #templates
[fonts]: #fonts
[additional tools]: #additional_tools

## Install / Upgrade

Download the image with:

```console
docker pull dalibo/pandocker:stable
```

Whenever a new stable version is released, launch that command again to refresh
your image.

## How To

Run `dalibo/pandocker`  with regular `pandoc` args. Mount your files at `/pandoc`.

```console
docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker README.md -o README.pdf
```

**Notes about the docker options:**

* The `-v ...` option will mount the current folder as the `/pandoc` directory
  inside the container. If SELinux is enabled on your system, you might need to
  add the `--privileged` tag to force access to the mouting points. For more
  details, read the documentation about [docker runtime privileges].

[docker runtime privileges]: https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities

* The `--rm` option destroys the container once the document is produced.
  This is not mandatory but it's a good practice.

* The `-u` option ensures that the output files will belong to you.
  Again this is not necessary but it's useful.

> Tip: You can define a shell alias to use `pandocker` just like `pandoc`.
> Add this to your `~/.bashrc` :

```console
alias pandoc="docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker:stable"
pandoc README.md -o README.epub
```

Alternatively, you can use a pipe like this:

```console
cat foo.md | docker run --rm -i dalibo/pandocker -t pdf > foo.pdf
```

This method will not work if the source document contains images or includes...

## Templates

We're shipping a selection of latex templates inside the image so that you
can produce nice PDF documents without installing anything.

So far, we provide the 3 templates below:

* [eisvogel] is designed for lecture notes and exercises with a focus on computer
  science. It works with `pdflatex` and `xelatex`.
* [easy templates] is a collection of HTML templates


You can use them simply by adding `--template=xxx` to your compilation
lines:

``` console
docker run [...] --pdf-engine=xelatex --template=eisvogel foo.md -o foo.pdf
```

Each template has specific variables that you can use to adapt the document.
Please go the project page of each template for more details.

[eisvogel]: https://github.com/Wandmalfarbe/pandoc-latex-template
[easy templates]: https://github.com/ryangrose/easy-pandoc-templates

## Filters

This docker image embeds a number of usefull pandoc filters. You can simply
enable them by adding the option `--filter xxx` where `xxx` is the name of
one of the following filters below:

* [panda] : Multi-purpose Lua filter
* [pandoc-citeproc] : manage bibliographies and citations
* [pandoc-codeblock-include] : insert an external file into a codeblock
* [pandoc-cover] : Add a PDF cover based on an SVG template
* [pandoc-include] : insert external markdown files into the main document
* [pandoc-latex-admonition] : adding admonitions on specific DIVs
* [pandoc-latex-barcode] : insert barcodes and QRcodes in documents
* [pandoc-latex-color] : Add colors to your PDF documents !
* [pandoc-latex-environment] : adding LaTeX environments on specific DIVs
* [pandoc-latex-fontsize] : Change size of a specific section of the document
* [pandoc-latex-margin] : Resize the margins of your PDF documents
* [pandoc-latex-newpage] : Convert horizontal rule to new page in LaTeX
* [pandoc-mustache] : basic variables substitution
* [pandoc-crossref] : support for cross-referencing sections, figures, and more
* [pandoc-run-postgres] : Execute SQL queries inside a markdown document
* [pandoc-jinja] : Render pandoc metadata inside the document itself

NOTE: By default when using the [pandoc-include] filter, the path to target
files is relative to the `/pandoc` mountpoint. For instance,
the `!include [foo/bar.md]` statement will look for a `/pandoc/foo/bar.md` file.
You can use the docker arg `--workdir="some/place/elsewhere"` to specify
another location. The same principle applies to the [pandoc-codeblock-include]
and [pandoc-mustache] filters.

[pando]: https://github.com/CDSoft/panda
[pandoc-cover]: https://github.com/daamien/pandoc-cover
[pandoc-citeproc]: https://pandoc.org/demo/example19/Extension-citations.html
[pandoc-codeblock-include]: https://github.com/chdemko/pandoc-codeblock-include
[pandoc-include]: https://github.com/DCsunset/pandoc-include
[pandoc-latex-admonition]: https://github.com/chdemko/pandoc-latex-admonition
[pandoc-latex-barcode]: https://github.com/daamien/pandoc-latex-barcode
[pandoc-latex-color]: https://github.com/chdemko/pandoc-latex-color
[pandoc-latex-environment]: https://github.com/chdemko/pandoc-latex-environment
[pandoc-latex-fontsize]: https://github.com/chdemko/pandoc-latex-fonsize
[pandoc-latex-margin]: https://github.com/chdemko/pandoc-latex-margin
[pandoc-latex-newpage]: https://github.com/chdemko/pandoc-latex-newpage
[pandoc-mustache]: https://github.com/michaelstepner/pandoc-mustache

[pandoc-crossref]: https://github.com/lierdakil/pandoc-crossref
[pandoc-run-postgres]: https://github.com/daamien/pandoc-run-postgres
[pandoc-jinja]: https://github.com/daamien/pandoc-jinja

## Fonts

The pandocker image includes the following open-source fonts:

* Deja Vu: <https://dejavu-fonts.github.io/>
* Lato: <https://fonts.google.com/specimen/Lato>
* Liberation: <https://github.com/liberationfonts/liberation-fonts>
* Fontawesome: <https://fontawesome.com/>

The full variant includes

* Noto: <https://www.google.com/get/noto/>

## Supported Tags : Branch + Variant + Parent

The image is available in 4 versions named as follows:

* `latest` (default): minimal image containing the most recent changes
* `stable` : minimal image based on the latest stable release
* `latest-full` (default): complete image containing the most recent changes
* `stable-full` : complete image based on the latest stable release

You can also the release names for instance

`docker pull dalibo/pandocker:24.05`

the previous versions add more complex tags such as `latest-ubuntu-extra` 
or `stable-buster`. They are not supported anymore.

## Build it

Use `make` or `docker build .`

## Additional tools

The docker image embeds additional software related to editing and publishing:

* [dia] a simple tool to design diagrams
* [poppler-utils] a collection of tools built to manage PDF and extract content
* [rsync] for deployment

[dia]: http://dia-installer.de/
[poppler-utils]: https://en.wikipedia.org/wiki/Poppler_(software)#poppler-utils
[rsync]: https://rsync.samba.org/documentation.html

These tools can be called by modifying the entrypoint of the image. For instance,
you can convert a `dia` source file into an SVG image like this:

``` console
docker run [..] --entrypoint dia dalibo/pandocker foo.dia -e foo.svg
```

### Frequently Asked Question

### ERROR: "filename": openBinaryFile: does not exist (No such file or directory)

When using pandocker, you may encounter the following error message:

```
$ docker run --rm -u `id -u`:`id -g` -v `pwd`:/pandoc dalibo/pandocker foo.md
pandoc: "filename": openBinaryFile: does not exist (No such file or directory)
```

This means that docker could not mount the local directory as a volume and
therefore pandoc cannot see the file `foo.md` inside the container. There might
be several reasons for that, here a few ideas to try:

1. Add `--privileged` option to the pandocker command line. Read more about
   this [docker privileged mode] here :
   <https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities>

2. Check if you have [SELinux] enforced on you system, with the command below:

```console
sestatus
```

If the [SELinux] mode is `enforced`, you can try to lower it to `permissive`.

More info about [SELinux] here: <https://fedoraproject.org/wiki/SELinux_FAQ>

[SELinux]: https://fedoraproject.org/wiki/SELinux_FAQ
[docker privileged mode]: https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities
