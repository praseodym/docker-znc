FROM debian:stretch

RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl unzip make g++ && \
    apt-get install -y --no-install-recommends -t stretch-backports znc znc-dev && \
    groupadd -r -g 500 znc && \
    useradd -m -r -u 500 -g znc znc && \
    cd /tmp && \
    curl -Lo znc-palaver.zip https://github.com/cocodelabs/znc-palaver/archive/master.zip && \
    unzip znc-palaver.zip && \
    cd znc-palaver-master && \
    make && \
    mkdir -p ~znc/.znc/modules && \
    cp palaver.so ~znc/.znc/modules && \
    cd && \
    apt-get autoremove -y --purge curl unzip make g++ znc-dev && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/*

EXPOSE 6667
USER znc
CMD znc -f
