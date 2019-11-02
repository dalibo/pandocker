Frequently Asked Questions
===============================================================================


ERROR: "filename": openBinaryFile: does not exist (No such file or directory)
--------------------------------------------------------------------------------

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
   https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities


2. Check if you have [SELinux] enforced on you system, with the command below:

```console
$ sestatus
```

If the [SELinux] mode is `enforced`, you can try to lower it to `permissive`.

More info about [SELinux] here: 
https://fedoraproject.org/wiki/SELinux_FAQ

[SELinux]: https://fedoraproject.org/wiki/SELinux_FAQ
[docker privileged mode]: https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities 

