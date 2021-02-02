# A simple Pandoc machine for pandoc with filters, fonts and the latex bazaar
#
# Based on :
#    https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
#    https://github.com/geometalab/docker-pandoc/blob/develop/Dockerfile
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile

FROM debian:buster-slim

# Proxy to APT cacher: e.g. http://apt-cacher-ng.docker:3142
ARG APT_CACHER

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

#
# Debian
#
RUN set -x && \
    # Setup a cacher to speed up build
    if [ -n "${APT_CACHER}" ] ; then \
        echo "Acquire::http::Proxy \"${APT_CACHER}\";" | tee /etc/apt/apt.conf.d/01proxy ; \
    fi; \
    apt-get -qq update && \
    apt-get -qy install --no-install-recommends \
        # for deployment
        openssh-client \
        rsync \
        # for locales and utf-8 support
        locales \
        # latex toolchain
        ghostscript \
        lmodern \
        texlive \
        texlive-lang-french \
        texlive-lang-german \
        texlive-lang-european \
        texlive-luatex \
        texlive-pstricks \
        texlive-xetex \
        xzdec \
        # reveal (see issue #18)
        netbase \
        # dia
        dia \
        # fonts
        fonts-dejavu \
        fonts-lato \
        fonts-liberation \
#        fonts-noto \    # /!\ noto = 63Mo
        # build tools
        make \
        git \
        parallel \
        wget \
        unzip \
        # panflute requirements
        python3-pip \
        python3-setuptools \
        python3-wheel \
        python3-yaml \
        # required for PDF meta analysis
        poppler-utils \
        zlibc \
        # for emojis
        librsvg2-bin \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/01proxy

#
# Set Locale for UTF-8 support
# This is needed for panflute filters see :
# https://github.com/dalibo/pandocker/pull/86
#
RUN locale-gen C.UTF-8
ENV LANG C.UTF-8

#
# SSH pre-config / useful for Gitlab CI
#
RUN mkdir -p ~/.ssh && \
    /bin/echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config # See Issue #87

#
# Add local cache/. It's empty by default so this does not change the final
# image on Docker Hub.
#
# However, once warmed with make warm-cache, it can save a lots of bandwidth.
#
ADD cache/ ./cache

#
# Install pandoc from upstream. Debian package is too old.
#
# When incrementing this version, also increment
# PANDOC_CROSSREF_VERSION below.
ARG PANDOC_VERSION=2.11.3
ADD fetch-pandoc.sh /usr/local/bin/
RUN fetch-pandoc.sh ${PANDOC_VERSION} ./cache/pandoc.deb && \
    dpkg --install ./cache/pandoc.deb && \
    rm -f ./cache/pandoc.deb

##
## F I L T E R S
##

#
# Python filters
#
ADD requirements.txt ./
RUN pip3 --no-cache-dir install --find-links file://${PWD}/cache -r requirements.txt

#
# pandoc-crossref
#
# This version must correspond to the correct PANDOC_VERSION.
# See https://github.com/lierdakil/pandoc-crossref/releases to find the latest
# release corresponding to the desired pandoc version.
ARG CROSSREF_REPO=https://github.com/lierdakil/pandoc-crossref/releases/download/
ARG CROSSREF_VERSION=0.3.9.0a
RUN wget ${CROSSREF_REPO}/v${CROSSREF_VERSION}/pandoc-crossref-Linux.tar.xz -O /tmp/pandoc-crossref.tar.xz && \
    tar xf /tmp/pandoc-crossref.tar.xz && \
    install pandoc-crossref /usr/local/bin/ && \
    install -d /usr/local/man/man1 && \
    install pandoc-crossref.1 /usr/local/man/man1/

##
## T E M P L A T E S
##

# kpsewhich -var-value=TEXMFLOCAL
ARG TEXMFLOCAL=/usr/local/share/texmf

# If docker is run with the `--user` option, the $HOME var
# is empty when the user does not exist inside the container.
# This causes several problems for pandoc and xelatex/pdftex.
# We solve the issue by putting the pandoc templates and the
# latex packages in shared spaces (TEXMFLOCAL, TEMPLATES_DIR)
# and creating symbolic links inside the `/root` home so that
# the templates and packages can be accessed by root and a
# non-existent `--user`
#
# See Bug #110 : https://github.com/dalibo/pandocker/issues/110
#

# CTAM packages are installed in the system-wide latex tree
# See `kpsewhich -var-value=TEXMFLOCAL`
ENV TEXMFLOCAL=/usr/local/share/texmf

# Templates are installed in '/.pandoc'.
ARG TEMPLATES_DIR=/.pandoc/templates

RUN mkdir -p ${TEMPLATES_DIR} && \
    mkdir /.texlive2016 && \
    # Links for the non-existent
    ln -s ${TEXMFLOCAL} /texmf && \
    # Links for the root user
    ln -s /.pandoc /root/.pandoc && \
    ln -s ${TEXMFLOCAL} /root/texmf && \
    ln -s /.texlive2016 /root/.texlive2016

# eisvogel template
ARG EISVOGEL_REPO=https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template
ARG EISVOGEL_VERSION=2.0.0
RUN wget ${EISVOGEL_REPO}/v${EISVOGEL_VERSION}/eisvogel.tex -O ${TEMPLATES_DIR}/eisvogel.latex
RUN tlmgr init-usertree && \
    # Debian/buster comes with TL2018, and thus refuses to work with the 2020 repositories, even in self mode
    tlmgr option repository ftp://tug.org/historic/systems/texlive/2018/tlnet-final && \
    tlmgr install ly1 inconsolata sourcesanspro sourcecodepro mweights || \
    # This first call returns an error but the packages are installed,
    # we call it again to check that everything is fine
    tlmgr install ly1 inconsolata sourcesanspro sourcecodepro mweights && \
    # update the font map
    updmap-sys

# letter template
ARG LETTER_REPO=https://raw.githubusercontent.com/aaronwolen/pandoc-letter
ARG LETTER_VERSION=master
RUN wget ${LETTER_REPO}/${LETTER_VERSION}/template-letter.tex -O ${TEMPLATES_DIR}/letter.latex

# leaflet template
ARG LEAFLET_REPO=https://gitlab.com/daamien/pandoc-leaflet-template/raw
ARG LEAFLET_VERSION=1.0
RUN wget ${LEAFLET_REPO}/${LEAFLET_VERSION}/leaflet.latex -O ${TEMPLATES_DIR}/leaflet.latex


##
## M I S C
##

#
# emojis support for latex
# https://github.com/mreq/xelatex-emoji
#
ARG TEXMF=/usr/share/texmf/tex/latex/
ARG EMOJI_DIR=/tmp/twemoji
RUN git clone --single-branch --depth=1 --branch gh-pages https://github.com/twitter/twemoji.git $EMOJI_DIR && \
    # fetch xelatex-emoji
    mkdir -p ${TEXMF} && \
    cd ${TEXMF} && \
    git clone --single-branch --branch images https://github.com/daamien/xelatex-emoji.git && \
    # convert twemoji SVG files into PDF files
    cp -r $EMOJI_DIR/2/svg xelatex-emoji/images && \
    cd xelatex-emoji/images && \
    ../bin/convert_svgs_to_pdfs ./*.svg && \
    # clean up
    rm -f *.svg && \
    rm -fr ${EMOJI_DIR} && \
    # update texlive
    cd ${TEXMF} && \
    texhash

VOLUME /pandoc
WORKDIR /pandoc

ENTRYPOINT ["pandoc"]
