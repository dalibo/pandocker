# A simple Pandoc machine for pandoc with filters, fonts and the latex bazaar
#
# Based on :
#    https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
#    https://github.com/geometalab/docker-pandoc/blob/develop/Dockerfile
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile

# switch to 2.20-ubuntu when released
# https://hub.docker.com/r/pandoc/extra/tags
FROM pandoc/extra:edge-ubuntu

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

#
# Ubuntu packages
#
RUN set -x && \
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
        # required for PDF meta analysis
        poppler-utils \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#
# Set Locale for UTF-8 support
# This is needed for panflute filters see :
# https://github.com/dalibo/pandocker/pull/86
#
RUN locale-gen C.UTF-8
ENV LANG C.UTF-8

#
# SSH pre-config / useful for Gitlab CI
# See Issue #87
#
RUN mkdir -p ~/.ssh && \
    /bin/echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

##
## R E V E A L J S
##

#
# The easiest to produce reveal slides is to point to a CDN like this:
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
ADD packages.txt ./
RUN tlmgr init-usertree && \
    tlmgr install `echo $(grep -v '^#' packages.txt )` && \
    # update the font map
    updmap-sys

##
##
## T E M P L A T E S
##


# Templates are installed in '/.pandoc'.
ARG TEMPLATES_DIR=/.pandoc/templates

# letter template
# DEPRECATED BUT KEPT FOR BACKWARD COMPAT
# Maybe switch to https://github.com/JensErat/pandoc-scrlttr2 ?
#ARG LETTER_REPO=https://raw.githubusercontent.com/aaronwolen/pandoc-letter
#ARG LETTER_VERSION=master
#RUN wget ${LETTER_REPO}/${LETTER_VERSION}/template-letter.tex -O ${TEMPLATES_DIR}/letter.latex

# leaflet template
# DEPRECATED BUT KEPT FOR BACKWARD COMPAT
#ARG LEAFLET_REPO=https://gitlab.com/daamien/pandoc-leaflet-template/raw
#ARG LEAFLET_VERSION=1.0
#RUN wget ${LEAFLET_REPO}/${LEAFLET_VERSION}/leaflet.latex -O ${TEMPLATES_DIR}/leaflet.latex

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
