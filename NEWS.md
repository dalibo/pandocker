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
