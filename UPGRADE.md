# Upgrade the Pandocker toolchain

## With docker

```
docker pull dalibo/pandocker:stable
```

## Without docker (local setup)

__TL;DR:__ We're releasing a stable version of the toolchain every 3 months and
we will only support the latest stable version. If you want to make your life
easier, use the docker image as described above.


### Upgrade from  18.06 to 18.08

```shell
sudo apt install fonts-liberation 
```


### Upgrade from 18.03 to 18.06


```shell
sudo apt install texlive-lang-german
```

### Upgrade from 17.12 to 18.03


1. Upgrade to Pandoc 2:

```shell
URL=https://github.com/jgm/pandoc/releases/download/2.1.3/pandoc-2.1.3-1-amd64.deb
wget -O pandoc.deb $URL
sudo dpkg --install pandoc.deb
```

2. Add more latex packages


```shell
sudo apt install texlive-luatex texlive-pstricks
```

3. Upgrade the filters

```shell
sudo pip3 install --upgrade -r requirements.txt
```

---

### Upgrade from 17.09 to 17.12

Upgrade is not possible :-(

You need to install a brand new `Debian Stretch` system and replay the entire
[install](INSTALL.md) process.

---

### Upgrade from 17.06 to 17.09

You need to add the levelup filter

```shell
sudo pip3 install pandoc-latex-levelup
```

---

### Upgrade from 17.03 to 17.06


The panflute module requires `python3`

```shell
sudo apt-get install python3 python3-dev python3-pip python3-virtualenv
sudo pip3 install panflute
```

The post-production script requires pypdf2

```shell
pip install pypdf2
```

