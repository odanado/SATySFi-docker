FROM ocaml/opam:debian-9_ocaml-4.05.0

USER root
RUN apt update && \
    apt install -y git autoconf wget --no-install-recommends && \
    apt clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ENV USER opam
USER $USER
ENV SATYSFI_LIB_ROOT /home/$USER/.opam/4.05.0/lib-satysfi
RUN mkdir -p $SATYSFI_LIB_ROOT/dist/fonts && \
    wget https://www.wfonts.com/download/data/2014/12/28/arno-pro/ArnoPro-Regular.otf -P $SATYSFI_LIB_ROOT/dist/fonts/ && \
    wget https://ipafont.ipa.go.jp/old/ipaexfont/ipaexm00201.php -P /tmp && \
    unzip -d /tmp /tmp/ipaexm00201.php && \
    cp /tmp/ipaexm00201/ipaexm.ttf $SATYSFI_LIB_ROOT/dist/fonts
    
RUN git clone https://github.com/gfngfn/SATySFi /home/opam/SATySFi

WORKDIR /home/opam/SATySFi

RUN git submodule update -i && \
    opam pin add -y satysfi . && \
    opam install -y satysfi
