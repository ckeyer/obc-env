FROM ckeyer/obc:base

MAINTAINER ckeyer <me@ckeyer.com>

RUN apk add --update curl autoconf automake libtool unzip 

RUN apk add --update python python-dev cython cython-dev && \
	curl https://bootstrap.pypa.io/get-pip.py | python

RUN cd /tmp && \
	git clone https://github.com/grpc/grpc.git && \
	cd grpc && \
	pip install -rrequirements.txt && \
	git checkout tags/release-0_13_1 && \
	sed -i -e "s/boringssl.googlesource.com/github.com\/linux-on-ibm-z/" .gitmodules && \
	git submodule sync && \
	git submodule update --init && \
	cd third_party/boringssl && \
	git checkout s390x-big-endian && \
	cd ../.. && \
	GRPC_PYTHON_BUILD_WITH_CYTHON=1 pip install . && \
	rm -rf /tmp/*

RUN cd /tmp && \
	git clone https://github.com/google/protobuf.git && \
	cd protobuf && \
	git checkout v3.0.0-beta-2 && \ 
	./autogen.sh && \
	./configure && \
	make && \
	make install && \
	rm -rf /tmp/*

RUN mkdir -p /go/src/github.com/golang && \
	git clone https://github.com/golang/protobuf.git /go/src/github.com/golang/protobuf && \
	cd /go/src/github.com/golang/protobuf && \
	git checkout efcaa340c1a788c79e1ca31217d66aa41c405a51 && \
	go install github.com/golang/protobuf/proto && \
	go install github.com/golang/protobuf/protoc-gen-go