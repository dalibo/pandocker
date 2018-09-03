# Install the Pandocker toolchain

## With docker

```
docker pull dalibo/pandocker:stable
```

## Without docker (local setup)

__TL;DR:__ The entire toolchain is a very _long_ and  _precise_ list of
dependencies : debian, latex, pandoc, etc. All versions are set in stone.
You can probably make it work `Fedora` or `Arch` but you will be in uncharted
territory. We will only provide support for this specific setup.

Also we follow a very fast release cycle and deliver a new stable version every 
3 months. This means that if you choose to install the toolchain locally, you 
will need to [upgrade](UPGRADE.md) manually your setup on a regular basis.

**In a nutshell** : If you want to make your life easier, use the docker image 
as described above.


### 1. Environment

Install Debian Stretch

### 2. Pandoc

```shell
URL=https://github.com/jgm/pandoc/releases/download/2.1.3/pandoc-2.1.3-1-amd64.deb
wget -O pandoc.deb $URL
dpkg --install pandoc.deb
```


### 3. The latex packages

Here be dragons ! Prepare yourself for 1 GB of obscure latex dependencies.

```shell
sudo apt install lmodern texlive texlive-lang-french texlive-lang-german \
                 texlive-luatex texlive-pstricks texlive-xetex \ 
								 fonts-lato fonts-liberation
```



### 4. Pandoc filters

We're using `python3` and `pip` to fetch the filters. The list of Python 
packages can be found in the [requirements.txt](requirements.txt) file.

```shell
sudo apt install python3-pip python3-setuptools python3-wheel python3-yaml
sudo pip3 install -r requirements.txt
```

The `sudo` prefix is important !

### 5. Misc.

Some tools for post-production :

```shell
sudo apt install openssh-client rsync poppler-utils zlibc make \
                 git parallel wget
```


