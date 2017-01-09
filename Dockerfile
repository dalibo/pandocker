# Based on :
#    https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
#    https://github.com/geometalab/docker-pandoc/blob/develop/Dockerfile
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile

FROM debian:latest
MAINTAINER damien clochard <daamien@gmail.com>

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

# pandoc/latex toolchain 
RUN apt-get -qq update && \
    apt-get -qq -y install pandoc texlive texlive-xetex && \
    apt-get -qq -y install wget tar xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# TODO: Install pandoc from https://github.com/jgm/pandoc/releases/

# Install wkhtmltopdf
RUN wget -O wkhtmltox.tar.xz http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox.tar.xz
ENV PATH ${PATH}:/wkhtmltopdf/wkhtmltox/bin

# Entrypoint
RUN mkdir /pandoc
WORKDIR /pandoc
ENTRYPOINT ["pandoc"]
CMD ["--help"]


