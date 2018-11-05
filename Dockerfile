# A simple Pandoc machine for pandoc with filters, fonts and the latex bazaar
#
# Based on :
#    https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
#    https://github.com/geometalab/docker-pandoc/blob/develop/Dockerfile
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile

FROM debian:stretch-slim

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
        # latex toolchain
        lmodern \
        texlive \
        texlive-lang-french \
		texlive-lang-german \
        texlive-luatex \
        texlive-pstricks \
        texlive-xetex \
		xzdec \
        # reveal (see issue #18)
        netbase \
        # fonts
        fonts-lato \
		fonts-liberation \
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
        # WeasyPrint
		build-essential \
        python3-dev \
        python3-pip \
        python3-cffi \
        libcairo2 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libgdk-pixbuf2.0-0 \
        libffi-dev \
        shared-mime-info \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/01proxy

#
# SSH pre-config / useful for Gitlab CI
#
RUN mkdir -p ~/.ssh && \
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

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
ARG PANDOC_VERSION=2.2.3.1
ADD fetch-pandoc.sh /usr/local/bin/
RUN fetch-pandoc.sh ${PANDOC_VERSION} ./cache/pandoc.deb && \
    dpkg --install ./cache/pandoc.deb && \
    rm -f ./cache/pandoc.deb

#
# Pandoc filters
#
ADD requirements.txt ./
RUN pip3 --no-cache-dir install --find-links file://${PWD}/cache -r requirements.txt


#
# eisvogel template
#
ARG TEMPLATES_DIR=/root/.pandoc/templates
RUN mkdir -p ${TEMPLATES_DIR} && \
	wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex -O ${TEMPLATES_DIR}/eisvogel.latex
RUN tlmgr init-usertree && \
	tlmgr install ly1 inconsolata sourcesanspro sourcecodepro mweights

VOLUME /pandoc
WORKDIR /pandoc

# Compatibility with Pandoc 1.x arguments
# use `--entrypoint=pandoc1.sh` to activate it
ADD pandoc1.sh /usr/local/bin

ENTRYPOINT ["pandoc"]
