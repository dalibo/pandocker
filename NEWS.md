Pandocker 20.02: the palindrome edition !
================================================================================

Paris, February 5th, 2020

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain
based on `pandoc` with filters, templates, fonts, and the latex bazaar

It allows you to generate slides and documents without installing the required
depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker test.md -o test.epub
```

This image is available under BSD Licence and it has 2 main tags:

* `dalibo/pandocker:stable` should be used in production ( = 20.20 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve older versions by their version number:
`dalibo/pandocker:20.02`, `dalibo/pandocker:19.11`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>


More templates, more fonts, more filters, more langs
--------------------------------------------------------------------------------

This is new version brings several new items:

* 2 more filters: [pandoc-crossref] and [pandoc-citeproc]
* 2 more templates: [leaflet] and [letter]
* 2 more fonts: Noto and Deja-Vu
* All european languages are now supported

[pandoc-crossref]: https://github.com/lierdakil/pandoc-crossref
[pandoc-citeproc]: https://github.com/jgm/pandoc-citeproc
[leaflet]: https://gitlab.com/daamien/pandoc-leaflet-template
[letter]:  https://github.com/aaronwolen/pandoc-letter

There's also some improvements on the existing tools:

* Pandoc has been updated to 2.9
* The [eisvogel] template has been upgraded to 1.4

Many thanks to @colindean and @DigitalTravelDuck for their contributions to these
features !


Using pandocker with pipes
--------------------------------------------------------------------------------

It is now possible to run the pandocker image as a 'black box' by passing the
source file through a pipe and collecting the result on the standard output.

For example:

```
$ cat foo.md | docker run --rm -i dalibo/pandocker -t pdf > foo.pdf
```

This is useful if you want to use pandocker in a stream or when you don't want
to mount a docker volume. However, this method will not work if the source
document contains images or includes external files...


How to upgrade
--------------------------------------------------------------------------------

```console
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>


How to contribute
--------------------------------------------------------------------------------

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Job>



---


Pandocker 19.11 is out !
================================================================================

Paris, november 12

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.

It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 19.11 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>


This is a maintenance release
--------------------------------------------------------------------------------

This is version brings very few changes. The version of Pandoc has been updated
and the embbeded template ([eisvogel]) has been upgraded too.



How to upgrade
--------------------------------------------------------------------------------

```console
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>


How to contribute
--------------------------------------------------------------------------------

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>



---

Pandocker 19.08 is out !
================================================================================

Paris, august 22nd

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.

It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 19.08 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>


What's new in version 19.08 ?
--------------------------------------------------------------------------------

### Include code blocks into your documents

You can now import code for an external file with this simple syntax :

~~~
``` { .sql include=query1.sql}
```
~~~

To use this plugin, just add `--filter pandoc-codeblock-include` to the command line.

For more details about this filter, check out [pandoc-codeblock-include].

[pandoc-codeblock-include]: https://github.com/chdemko/pandoc-codeblock-include/wiki


### Dia

You can now convert `dia` files to SVG or PNG with the command line below:

```console
$ docker run [...] --entrypoint dia dalibo/pandocker foo.dia -e foo.svg
```

How to upgrade
--------------------------------------------------------------------------------

```console
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>


How to contribute
--------------------------------------------------------------------------------

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>




---

Pandocker 19.05 is out !
================================================================================

Paris, june 27th

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.

It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 19.05 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>


What's new in version 19.05 ?
--------------------------------------------------------------------------------

### Include files into your documents

You can now import content for an external markdown file with this simple
syntax :

```
!include relative_path/foo.md
```

To use this plugin, just add `--filter pandoc-include` to the command line.

For more details about this filter, check out [pandoc-include].

[pandoc-include]: https://github.com/DCsunset/pandoc-include

Many thanks to @misamura who submitted this feature !


How to upgrade
--------------------------------------------------------------------------------

```console
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>



How to contribute
--------------------------------------------------------------------------------

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>



---

Pandocker 19.02 is out !
================================================================================

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.
It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 18.02 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>



What's new in version 19.02 ?
--------------------------------------------------------------------------------

### A brand new Dokuwiki Reader

Pandoc is now able to parse dokuwiki pages ! You can now use pandocker as
converter to migrate from dokuwiki to markdown.

```console
docker run [...] --from dokuwiki source.doku.txt --to markdown
```


### Emojis ! 😎

Emojis are supported with the latex engine for PDF output (they were already
supported for revealjs and HTML outputs).

Simply add the following `header-include` parameter in your documents

```markdown
---
title: Hello, 🌍
header-includes: |
    \usepackage{xltxtra}
    \usepackage{xelatexemoji}
---

😀
```

And then run pandocker as always:

```
docker run [...] --pdf-engine=xelatex lol.md -o lol.pdf
```

### Mustache

Pandocker now allows you to put variables into your markdown documents, with
their values stored in a separate file. The language we use is the `mustache`
template syntax.

You can simply add variables like this

```markdown
---
mustache:
- tests/vars.yml
---

Rapport par {{auteur}}, relu par {{relecteur}}
```

And then define the variables in the `tests/vars.yml` file :

```YAML
auteur: Satsuki
relecteur: Mei
```

To activate this option, add the mustache filter to your command line


```console
docker run [...] --filter pandoc-mustache [...]
```

How to upgrade
--------------------------------------------------------------------------------

```console
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>



How to contribute
--------------------------------------------------------------------------------

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>


---


Pandocker 18.11 is out !
================================================================================

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.
It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 18.11 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>



What's new in version 18.11 ?
--------------------------------------------------------------------------------

### Eisvogel, a new template for everyone

We're now shipping a latex template inside the image so that you can produce a
nice PDF without installing anything.

The template is called [eisvogel] and you can use it simply by adding
`--template=eisvogel` to your compilation lines:

```
docker run [...] --pdf-engine=xelatex --template=eisvogel foo.md -o foo.pdf
```

[eisvogel]: https://github.com/Wandmalfarbe/pandoc-latex-template

### End of pandoc 1.x automatic support

Since version 18.03, we're using Pandoc 2 and starting with this version some
old parameters will no longer be supported. You need to check your compilation
lines and make the following changes :

* replace `--latex-engine` by `--pdf-engine`
* replace `--no-tex-ligatures` by `--from=markdown-smart`

As an alternative, you can also changer the entrypoint and call the `pandoc1.sh`
compatibility wrapper

```
docker run [...] --entrypoint=/usr/local/bin/pandoc1.sh [...]
```

### Easy PDF with WeasyPrint

We're now publishing a dedicated image including [WeasyPrint], alternative pdf
engine that generates PDF files from using HTML/CSS templates.

[WeasyPrint]: https://weasyprint.org/samples/

To use this template, you can simply use tag `weasy`:

```
docker run [...] dalibo/pandocker:weasy \
                    --pdf-engine=weasyprint` \
                    --pdf-engine-opt="--stylesheet template.css" \
                    --template=template.html \
                    foo.md \
                    -o foo.pdf
```

We're currently testing this new engine, please send us feedback if you're
using it too !


How to upgrade
--------------------------------------------------------------------------------

```
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>



How to contribute
--------------------------------------------------------------------------------

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>


---

Pandocker 18.08 is out !
================================================================================

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.
It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 18.06 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>



What's new in version 18.08 ?
--------------------------------------------------------------------------------

### New Release Cycle

The next images will be published in november, february, may and august.

### New Font : Liberation Mono

We added a new Font espacially for code blocks.


### Beware of for depracated parameters

Since version 18.03, we're using Pandoc 2 and we added a wrapper that supports
pandoc 1.x parameters. This is the last version that will automatically
support pandoc 1.x.

We'll continue to deliver the pandoc1 wrapper in the next versions but you
should consider updating your compilation flags as soon as possible.


How to upgrade
--------------------------------------------------------------------------------

```
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>



How to contribute
--------------------------------------------------------------------------------

This release is brought to you by Damien Clochard with the help of Etienne
Bersac and Eric Lemoine.

Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>


---


Pandocker 18.06 is out !
================================================================================

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.
It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 18.06 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>



What's new in version 18.06 ?
--------------------------------------------------------------------------------

### Pandocker spricht Deutsch

We added support for german charset.


### Beware of for depracated parameters

Since version 18.03, we're using Pandoc 2 and it introduced 2 incompatibilities:

* `--latex-engine` is now named `--pdf-engine`
* `--no-tex-ligatures` is replaced by `--from=markdown-smart`

We added a wrapper that automatically supports both pandoc 1.x and
2.x parameters, but in the long run you should consider updating your
compilation flags.


How to upgrade
--------------------------------------------------------------------------------

```
docker pull dalibo/pandocker:stable
```

If you installed the toolchain locally, please read:
<https://github.com/dalibo/pandocker/blob/master/UPGRADE.md#without-docker-local-setup>



How to contribute
--------------------------------------------------------------------------------

This release is brought to you by Damien Clochard with the help of Michael Mayer.
Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>


---

Pandocker 18.03 is out !
================================================================================

What is this ?
--------------------------------------------------------------------------------

Pandocker is a docker image containing a complete document production toolchain.
It allows you to generate slides and documents using `pandoc`, but without
installing the required depencies on your machine.

For instance to generate an EPUB file from a markdown source, you can simply
type:

```
docker run --rm -v `pwd`:/pandoc dalibo/pandocker:stable test.md -o test.epub
```

This image is available under BSD Licence and it is designed to work without
specific templates.

The project has 2 main branchs:

* `dalibo/pandocker:stable` should be used in production ( = 18.03 )
* `dalibo/pandocker:latest` is the development version

You can also retrieve images by their version number : `dalibo/pandocker:18.03`,
`dalibo/pandocker:17.12`, etc.

For more details :

* Github : <https://github.com/dalibo/pandocker>
* Docker Hub : <https://hub.docker.com/r/dalibo/pandocker/>



What's new in version 18.03 ?
--------------------------------------------------------------------------------

### We switched to Pandoc 2

Pandoc 2 was released in october 2017 and brings tons of great new features.
It also introduce a few incompatibilities as some parameters have been abruptly
renamed:

* `--latex-engine` is now named `--pdf-engine`
* `--no-tex-ligatures` is replaced by `--from=markdown-smart`

Hopefully we added a wrapper that automatically supports both pandoc 1.x and
2.x parameters, but in the long run you should consider updating your
compilation flags.


### We lost weight

The size of the previous image was 1.2GB (uncompressed). We reduced this to
735MB. We stripped down the image by removing a lot of unused LaTeX packages.
If you're missing one, please fill a bug report here :

<https://github.com/dalibo/pandocker/issues>

### Beamer is Back !

We restored the beamer export mode. You can simply get PDF slides like this:

```
docker run --rm -v `pwd`:/pandoc  dalibo/pandocker:stable -t beamer foo.md - o foo.beamer.pdf
```


How to contribute
--------------------------------------------------------------------------------

This release is brought to you by Étienne Bersac, Damien Clochard and Julien
Tachoires. Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>
