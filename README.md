# pandocker

A simple docker for pandoc with filters, fonts, and the latex bazaar

# Build

```
docker build .
```

or just :

```
docker pull daamien/pandocker
```

# How To

Add this to your `~/.bashrc` :

```
alias pandoc="docker run -v `pwd`:/pandoc daamien/pandocker $@"
```


# Branches 

You can use different versions of this machine using the following tags:

  * `latest`  : this is the default  (based on `master` branch)
  * `jessie`  : based on debian 8
  * `jtretch` : based on debian 9
  * `devel`   : based on the upcoming ubuntu distro
