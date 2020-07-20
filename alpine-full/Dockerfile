FROM dalibo/pandocker:alpine


RUN apk --no-cache add \
        font-noto

RUN tlmgr update --self && \
    tlmgr install \
        dejavu \
        collection-fontsrecommended \
        lato


RUN wget http://www.latofonts.com/download/Lato2OFL.zip -O /tmp/lato.zip && \
    unzip /tmp/lato.zip -d /usr/share/fonts && \
    wget https://github.com/googlefonts/noto-emoji/raw/master/fonts/NotoColorEmoji.ttf -O /usr/share/fonts/NotoColorEmoji.ttf && \
    wget https://github.com/googlefonts/noto-emoji/raw/master/fonts/NotoEmoji-Regular.ttf -O /usr/share/fonts/NotoEmoji-Regular.ttf && \
    fc-cache -fv


