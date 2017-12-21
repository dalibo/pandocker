# pandocker

A simple docker for pandoc with filters, fonts, and the latex bazaar

## Build

```
make
```

or 

```
docker build .
```

or just fetch the pre-compiled image :

```
docker pull daamien/pandocker
```

## How To

Add this to your `~/.bashrc` :

```
alias pandoc="docker run --rm -v `pwd`:/pandoc dalibo/pandocker $@"
```


Note: if SELinux is enabled on you system, you might need to add the
`--privileged` tag to force access to the mouting points.


More on this:
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities

## Branches 

You can use different versions of this machine using the following tags:

  * `latest`  : this is the default  (based on `master` branch)
  * `jessie`  : based on debian 8
  * `stretch` : based on debian 9
  * `devel`   : based on the upcoming ubuntu distro
