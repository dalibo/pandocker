# A simple Pandoc machine for pandoc with filters, fonts and the latex bazaar
#
# Based on :
#    https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
#    https://github.com/geometalab/docker-pandoc/blob/develop/Dockerfile
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile

FROM debian:stretch-slim

# Proxy to APT cacher: e.g. http://apt-cacher-ng.docker:3142
ARG APT_CACHER

# Pandoc Version
ENV PANDOC_SOURCE https://github.com/jgm/pandoc/releases/
ENV PANDOC_VERSION 1.19.2
ENV DEBIAN_REVISION ${PANDOC_VERSION}-1

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
        texlive \
        texlive-xetex \
        # fonts
        fonts-lato \
        # build tools
        git \
        parallel \
        python-pip \
        python-setuptools \
        wget \
        # pandoc-latex-tip requirements
        libjpeg62-turbo-dev \
        libfreetype6 \
        libfreetype6-dev \
        python-imaging \
        # panflute requirements
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        # required for PDF meta analysis
        poppler-utils \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#
# SSH pre-config / useful for Gitlab CI
#
RUN mkdir -p ~/.ssh && \
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

#
# Install pandoc from github / debian package is too old 
#
RUN wget -O pandoc.deb ${PANDOC_SOURCE}/download/${PANDOC_VERSION}/pandoc-${DEBIAN_REVISION}-amd64.deb && \
    dpkg --install pandoc.deb

#
# Pandoc filters
#
RUN pip install pandocfilters \
    		pandoc-latex-environment \
                pandoc-latex-barcode \
                pandoc-latex-levelup \
                pandoc-dalibo-guidelines \ 
                icon_font_to_png \
                pypdf2  
 
# https://github.com/chdemko/pandoc-latex-tip/issues/1
RUN pip install git+https://github.com/chdemko/pandoc-latex-tip.git --egg

# planflute does not like python2
RUN pip3 install panflute \
		 pandoc-latex-admonition

# Additional Python modules
#RUN pip install pypdf2  

# Entrypoint
RUN mkdir /pandoc
WORKDIR /pandoc
ENTRYPOINT ["pandoc"]
