FROM alpine:edge

MAINTAINER Chuanjian Wang <me@ckeyer.com>

RUN apk add --update rocksdb sqlite --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing && \
	apk add --update snappy zlib libbz2 && \
	rm -rf /var/cache/apk/*

ADD bin /usr/local/bin

WORKDIR /usr/local/bin