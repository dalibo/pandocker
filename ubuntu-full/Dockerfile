# This versions extends the buster image with :
#
# * International Fonts
# * Emojis
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile
#
FROM dalibo/pandocker:2.19-ubuntu

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
        #
        texlive-lang-other \
        # hindi fonts
        fonts-deva \
        # persian fonts
        texlive-lang-arabic \
        fonts-farsiweb \
        # dia
        dia \
        # Noto font families with large Unicode coverage
        fonts-noto \
        fonts-noto-cjk \
        fonts-noto-cjk-extra \
        fonts-noto-color-emoji \
        fonts-noto-core \
        fonts-noto-extra \
        fonts-noto-mono \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/01proxy

##
## L A T E X
##
ADD latex_requirements.full.txt ./
RUN tlmgr init-usertree && \
    tlmgr install `echo $(grep -v '^#' latex_requirements.full.txt )` && \
    # update the font map
    updmap-sys



##
## E N T R Y P O I N T
##
VOLUME /pandoc
WORKDIR /pandoc

ENTRYPOINT ["pandoc"]
