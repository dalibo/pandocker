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
