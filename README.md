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
alias pandoc="docker run --rm -v `pwd`:/pandoc daamien/pandocker $@"
```


## Branches 

You can use different versions of this machine using the following tags:

  * `latest`  : this is the default  (based on `master` branch)
  * `jessie`  : based on debian 8
  * `stretch` : based on debian 9
  * `devel`   : based on the upcoming ubuntu distro
