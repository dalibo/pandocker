# A simple Pandoc machine for pandoc with filters, fonts and the latex bazaar
#
# Based on :
#    https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
#    https://github.com/geometalab/docker-pandoc/blob/develop/Dockerfile
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile

FROM pandoc/latex:2.19-ubuntu

# Proxy to APT cacher: e.g. http://apt-cacher-ng.docker:3142
ARG APT_CACHER

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

#
# Ubuntu packages
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
        texlive-lang-spanish \
        texlive-luatex \
        texlive-pstricks \
        texlive-xetex \
        xzdec \
        # reveal (see issue #18)
        netbase \
        # fonts
        fonts-dejavu \
        fonts-font-awesome \
        fonts-lato \
        fonts-liberation \
        # build tools
        make \
        git \
        parallel \
        wget \
        unzip \
        # panflute requirements
        python-is-python3 \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        python3-yaml \
        # required for PDF meta analysis
        poppler-utils \
        #zlib \
        # svg conversion
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

##
## R E V E A L J S
##

#
# The easiest way to produce reveal slides is to point to a CDN like this:
#
#    -V revealjs-url=https://unpkg.com/reveal.js
#
# However it's useful to have revealjs inside pandocker when you want
# to build offline
#

# pandoc 2.10+ requires revealjs 4.x
ARG REVEALJS_VERSION=4.1.2
RUN wget https://github.com/hakimel/reveal.js/archive/${REVEALJS_VERSION}.tar.gz -O revealjs.tar.gz && \
    tar -xzvf revealjs.tar.gz && \
    cp -r reveal.js-${REVEALJS_VERSION}/dist / && \
    cp -r reveal.js-${REVEALJS_VERSION}/plugin /


##
## F I L T E R S
##

# Python filters
ADD requirements.txt ./
RUN pip3 --no-cache-dir install -r requirements.txt

# Lua filters
ARG PANDA_REPO=https://github.com/CDSoft/panda.git
ARG PANDA_VERSION=8dcbe68
RUN git clone ${PANDA_REPO} /tmp/panda && \
    cd /tmp/panda && \
    git checkout ${PANDA_VERSION} && \
    make install && \
    rm -fr /tmp/panda


##
## L A T E X
##
ADD latex_requirements.txt ./
RUN tlmgr init-usertree && \
    tlmgr install `echo $(grep -v '^#' latex_requirements.txt )` && \
    # update the font map
    updmap-sys

##
##
## T E M P L A T E S
##

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
#ARG EISVOGEL_VERSION=v2.0.0
# HOT FIX: Pandoc is turning away from polyglossia and currently (nov. 2022) we need
# a more recent version of eisvogel
# https://github.com/jgm/pandoc/pull/7562
# https://github.com/Wandmalfarbe/pandoc-latex-template/issues/278
ARG  EISVOGEL_VERSION=f5c1f20c94fa7fef4750ce46589416520bd76768
RUN wget ${EISVOGEL_REPO}/${EISVOGEL_VERSION}/eisvogel.tex -O ${TEMPLATES_DIR}/eisvogel.latex

# letter template
# DEPRECATED BUT KEPT FOR BACKWARD COMPAT
# Maybe switch to https://github.com/JensErat/pandoc-scrlttr2 ?
ARG LETTER_REPO=https://raw.githubusercontent.com/aaronwolen/pandoc-letter
ARG LETTER_VERSION=master
RUN wget ${LETTER_REPO}/${LETTER_VERSION}/template-letter.tex -O ${TEMPLATES_DIR}/letter.latex

# leaflet template
# DEPRECATED BUT KEPT FOR BACKWARD COMPAT
ARG LEAFLET_REPO=https://gitlab.com/daamien/pandoc-leaflet-template/raw
ARG LEAFLET_VERSION=1.0
RUN wget ${LEAFLET_REPO}/${LEAFLET_VERSION}/leaflet.latex -O ${TEMPLATES_DIR}/leaflet.latex

# Easy templates
ARG EASY_REPO=https://raw.githubusercontent.com/ryangrose/easy-pandoc-templates/
ARG EASY_VERSION=9a884190fe19782f4434851053947173f8cec3d2

RUN wget ${EASY_REPO}/${EASY_VERSION}/html/uikit.html -O ${TEMPLATES_DIR}/uikit.html && \
    wget ${EASY_REPO}/${EASY_VERSION}/html/bootstrap_menu.html -O ${TEMPLATES_DIR}/bootstrap_menu.html && \
    wget ${EASY_REPO}/${EASY_VERSION}/html/clean_menu.html -O ${TEMPLATES_DIR}/clean_menu.html && \
    wget ${EASY_REPO}/${EASY_VERSION}/html/easy_template.html -O ${TEMPLATES_DIR}/easy_template.html && \
    wget ${EASY_REPO}/${EASY_VERSION}/html/elegant_bootstrap_menu.html -O ${TEMPLATES_DIR}/elegant_bootstrap_menu.html


##
## E N D
##
VOLUME /pandoc
WORKDIR /pandoc

ENTRYPOINT ["pandoc"]
