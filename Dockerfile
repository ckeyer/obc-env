FROM ckeyer/obc:base

MAINTAINER ckeyer <me@ckeyer.com>

RUN apk add --update curl autoconf automake libtool unzip 

RUN cd /tmp && \
	git clone https://github.com/google/protobuf.git && \
	cd protobuf && \
	git checkout v3.0.0-beta-2 && \ 
	./autogen.sh && \
	./configure && \
	make && \
	make check && \
	make install && \
	rm -rf /tmp/*

RUN go get -u github.com/golang/protobuf/proto && \ 
	go get -u github.com/golang/protobuf/protoc-gen-go