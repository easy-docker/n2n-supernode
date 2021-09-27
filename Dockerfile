FROM alpine AS builder

MAINTAINER Ghostry (ghostry@ghostry.cn)
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add linux-headers build-base bash autoconf automake git && \
    cd / && \
    git clone https://github.com/ntop/n2n.git && \
    cd n2n && \
    ./autogen.sh && \
    ./configure --with-zstd --with-openssl CFLAGS="-DSN_SELECTION_RTT" && \
    make

FROM alpine

ENV PARAMETER "-v"

COPY --from=builder /n2n/supernode /usr/bin
COPY startup.sh /

EXPOSE 7654/udp
EXPOSE 5645/udp

CMD ["/startup.sh"]
