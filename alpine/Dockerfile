FROM pandoc/latex:2.17.0.1

RUN apk --no-cache add \
        bash \
        py3-pip \
        rsync \
        openssh-client \
        fontconfig \
        ttf-liberation \
        dia \
        librsvg

RUN tlmgr update --self && \
    tlmgr install \
        # lang-french: https://packages.debian.org/sid/texlive-lang-french
        aeguill \
        babel-french \
        bib-fr \
        bibleref-french \
        booktabs-fr \
        droit-fr \
        e-french \
        epslatex-fr \
        frenchmath \
        frletter \
        hyphen-french \
        impnattypo \
        mafr \
        tdsfrmath \
        # lang-european: https://packages.debian.org/sid/texlive-lang-european
        babel-dutch \
        hyphen-dutch \
        #lang-german: https://packages.debian.org/sid/texlive-lang-german
        babel-german \
        xpatch \
        #lang-spanish: https://packages.debian.org/unstable/texlive-lang-spanish
        babel-spanish \
        hyphen-spanish \
        # minted
        minted \
        ifplatform \
        etoolbox \
        xstring \
        # template-eisvogel: https://github.com/Wandmalfarbe/pandoc-latex-template#texlive
        adjustbox \
        background \
        bidi \
        collectbox \
        csquotes \
        everypage \
        filehook \
        footmisc \
        footnotebackref \
        framed \
        fvextra \
        letltxmacro \
        ly1 \
        mdframed \
        mweights \
        needspace \
        pagecolor \
        sourcecodepro \
        sourcesanspro \
        titling \
        ucharcat \
        ulem \
        unicode-math \
        upquote \
        xecjk \
        xurl \
        zref \
        # template-leaflet
        leaflet \
        transparent \
        titlesec \
        # template-letter
        wallpaper \
        # fonts
        ec \
        cm-super \
        fontawesome5 \
        # misc.
        catchfile


##
## R E V E A L J S
##

# pandoc 2.10+ requires revealjs 4.x
ARG REVEALJS_VERSION=4.1.2
RUN wget https://github.com/hakimel/reveal.js/archive/${REVEALJS_VERSION}.tar.gz -O revealjs.tar.gz && \
    tar -xzvf revealjs.tar.gz && \
    cp -r reveal.js-${REVEALJS_VERSION}/dist / && \
    cp -r reveal.js-${REVEALJS_VERSION}/plugin /

##
## F I L T E R S
##

ADD requirements.txt ./
RUN pip3 --no-cache-dir install -r requirements.txt

#
# pandoc-crossref
#
# This version must correspond to the correct PANDOC_VERSION.
# See https://github.com/lierdakil/pandoc-crossref/releases to find the latest
# release corresponding to the desired pandoc version.
ARG CROSSREF_REPO=https://github.com/lierdakil/pandoc-crossref/releases/download/
ARG CROSSREF_VERSION=0.3.12.2
RUN wget ${CROSSREF_REPO}/v${CROSSREF_VERSION}/pandoc-crossref-Linux.tar.xz -O /tmp/pandoc-crossref.tar.xz && \
    tar xf /tmp/pandoc-crossref.tar.xz && \
    install pandoc-crossref /usr/local/bin/


# Templates are installed in '/.pandoc'.
ARG TEMPLATES_DIR=/.pandoc/templates

RUN mkdir -p ${TEMPLATES_DIR} && \
    # Links for the root user
    ln -s /.pandoc /root/.pandoc

# eisvogel template
ARG EISVOGEL_REPO=https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template
ARG EISVOGEL_VERSION=2.0.0
RUN wget ${EISVOGEL_REPO}/v${EISVOGEL_VERSION}/eisvogel.tex -O ${TEMPLATES_DIR}/eisvogel.latex

# letter template
ARG LETTER_REPO=https://raw.githubusercontent.com/aaronwolen/pandoc-letter
ARG LETTER_VERSION=master
RUN wget ${LETTER_REPO}/${LETTER_VERSION}/template-letter.tex -O ${TEMPLATES_DIR}/letter.latex

# leaflet template
ARG LEAFLET_REPO=https://gitlab.com/daamien/pandoc-leaflet-template/raw
ARG LEAFLET_VERSION=1.0
RUN wget ${LEAFLET_REPO}/${LEAFLET_VERSION}/leaflet.latex -O ${TEMPLATES_DIR}/leaflet.latex

VOLUME /pandoc
WORKDIR /pandoc


