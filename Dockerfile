FROM debian:latest
MAINTAINER damien clochard <daamien@gmail.com>

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

# pandoc/latex toolchain 
RUN apt-get -qq update && \
    apt-get -qq -y install pandoc texlive texlive-xetex  


# Install wkhtmltopdf
RUN apt-get -qq -y install wget tar xz-utils
WORKDIR /wkhtmltopdf
RUN wget -O wkhtmltox-0.12.3_linux-generic-amd64.tar.xz http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
ENV PATH ${PATH}:/wkhtmltopdf/wkhtmltox/bin

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* 

WORKDIR /pandoc
