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

### We lost weight

### Beamer is Back !



How to contribute
--------------------------------------------------------------------------------

This release is brought to you by Etienne Bersac, Damien Clochard and Julien 
Tachoires. Pandocker is an open project, contributions are welcome.

If you want to help, you can find a list of "Junior Jobs" here:

<https://github.com/dalibo/pandocker/labels/Junior%20Jobs>