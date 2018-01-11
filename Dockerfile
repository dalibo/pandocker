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
        texlive-xetex \
        # fonts
        fonts-lato \
        # build tools
        git \
        parallel \
        wget \
        # panflute requirements
        python3-pillow \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        python3-yaml \
        # required for PDF meta analysis
        poppler-utils \
        zlibc \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/01proxy

#
# SSH pre-config / useful for Gitlab CI
#
RUN mkdir -p ~/.ssh && \
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

#
# Install pandoc from upstream. Debian package is too old.
#
ARG PANDOC_VERSION=1.19.2
RUN wget -O pandoc.deb https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb && \
    dpkg --install pandoc.deb && \
    rm -f pandoc.deb

#
# Pandoc filters
#
RUN pip3 --no-cache-dir install \
        panflute \
        pandocfilters \
        pandoc-latex-admonition \
        pandoc-latex-environment \
        pandoc-latex-barcode \
        pandoc-latex-levelup \
        pandoc-latex-tip \
        pandoc-dalibo-guidelines \
        icon_font_to_png \
        pypdf2 \
        ${NULL-}

VOLUME /pandoc
WORKDIR /pandoc
ENTRYPOINT ["pandoc"]
