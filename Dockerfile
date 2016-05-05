FROM alpine:edge
MAINTAINER ckeyer <me@ckeyer.com>

RUN apk add --update rocksdb-dev --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing && \
	apk add --update sqlite-dev --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing && \ 
	apk add --update snappy-dev && \ 
	apk add --update zlib-dev && \
	apk add --update libbz2 && \
	apk add --update git && \
	apk add --update wget && \
	apk add --update vim && \
	apk add --update go && \
	apk add --update make && \
	apk add --update gcc && \
	apk add --update g++ && \
	rm -rf /var/cache/apk/*

ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin

WORKDIR $GOPATH