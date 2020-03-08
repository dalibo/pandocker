FROM pandoc/latex:2.9.2


RUN apk --no-cache add \
        py3-pip \
        rsync \
        openssh-client \
        fontconfig \
        ttf-dejavu \
        ttf-liberation \
        font-noto

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
        dejavu \
        collection-fontsrecommended \
        lato \
        # misc.
        catchfile


RUN wget http://www.latofonts.com/download/Lato2OFL.zip -O /tmp/lato.zip && \
    unzip /tmp/lato.zip -d /usr/share/fonts && \
    wget https://github.com/googlefonts/noto-emoji/raw/master/fonts/NotoColorEmoji.ttf -O /usr/share/fonts && \
    wget https://github.com/googlefonts/noto-emoji/raw/master/fonts/NotoEmoji-Regular.ttf -O /usr/share/fonts && \
    fc-cache -fv

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
ARG CROSSREF_VERSION=0.3.6.2
RUN wget ${CROSSREF_REPO}/v${CROSSREF_VERSION}/linux-pandoc_2_9_2.tar.gz -O /tmp/pandoc-crossref.tar.gz && \
    tar xf /tmp/pandoc-crossref.tar.gz && \
    install pandoc-crossref /usr/local/bin/


# Templates are installed in '/.pandoc'.
ARG TEMPLATES_DIR=/.pandoc/templates

RUN mkdir -p ${TEMPLATES_DIR} && \
    # Links for the root user
    ln -s /.pandoc /root/.pandoc

# eisvogel template
ARG EISVOGEL_REPO=https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template
ARG EISVOGEL_VERSION=v1.4.0
RUN wget ${EISVOGEL_REPO}/${EISVOGEL_VERSION}/eisvogel.tex -O ${TEMPLATES_DIR}/eisvogel.latex

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


