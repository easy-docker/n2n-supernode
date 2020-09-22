FROM alpine AS builder

MAINTAINER Ghostry (ghostry@ghostry.cn)

RUN apk add linux-headers build-base bash autoconf && \
    cd / && \
    wget https://github.com/ntop/n2n/archive/2.8.tar.gz && \
    tar zxvf 2.8.tar.gz && \
    cd n2n-2.8 && \
    ./autogen.sh && \
    ./configure && \
    make

FROM alpine

COPY --from=builder /n2n-2.8/supernode /usr/bin

EXPOSE 7654/udp
EXPOSE 5645/udp

ENTRYPOINT ["/usr/bin/supernode", "-v"]
