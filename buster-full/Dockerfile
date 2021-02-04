# This versions extends the buster image with :
#
# * International Fonts
# * Emojis
#    https://github.com/vpetersson/docker-pandoc/blob/master/Dockerfile
#
FROM dalibo/pandocker:latest-buster

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
        # for emojis
        librsvg2-bin \
    # clean up
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/01proxy

##
## M I S C
##

#
# emojis support for latex
# https://github.com/mreq/xelatex-emoji
#
ARG TEXMF=/usr/share/texmf/tex/latex/
ARG EMOJI_DIR=/tmp/twemoji2
RUN git clone --single-branch --depth=1 --branch gh-pages https://github.com/twitter/twemoji.git $EMOJI_DIR && \
    # fetch xelatex-emoji
    mkdir -p ${TEXMF} && \
    cd ${TEXMF} && \
    git clone --single-branch --branch images https://github.com/daamien/xelatex-emoji.git xelatex-emoji2 && \
    # convert twemoji SVG files into PDF files
    cp -r $EMOJI_DIR/2/svg xelatex-emoji2/images && \
    cd xelatex-emoji2/images && \
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
