FROM centos:7

MAINTAINER Chuanjian Wang <me@ckeyer.com>

RUN yum install -y make gcc gcc-c++ snappy snappy-devel zlib zlib-devel bzip2 bzip2-devel vim git unzip wget 

### install golang
ENV GOROOT=/usr/local/go
ENV GOPATH=/opt/gopath
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
RUN cd /usr/local && \
	wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz && \
	tar zxf go1.7.3.linux-amd64.tar.gz && \
	rm -f go1.7.3.linux-amd64.tar.gz

### install RocksDB
RUN cd /tmp && \
	wget https://github.com/facebook/rocksdb/archive/v4.1.tar.gz && \
	tar zxf v4.1.tar.gz && \
	rm -f v4.1.tar.gz && \
	cd rocksdb-4.1 && \
	PORTABLE=1 make shared_lib && \
	INSTALL_PATH=/usr/local make install-shared && \
	ldconfig && \
	ln -s /usr/local/lib/librocksdb.so.4.1.0 /lib64/librocksdb.so.4.1 && \
	rm -rf /tmp/*

### install protoc-gen-go (efcaa340c1a788c79e1ca31217d66aa41c405a51)
RUN go get github.com/golang/protobuf/proto && \
	go get github.com/golang/protobuf/protoc-gen-go

### install protoc 
RUN cd /usr && \
	wget https://github.com/google/protobuf/releases/download/v3.0.2/protoc-3.0.2-linux-x86_64.zip && \
	unzip protoc-3.0.2-linux-x86_64.zip && \
	rm -f protoc-3.0.2-linux-x86_64.zip

RUN go get github.com/ckeyer/go-bindata/... 2>&1
RUN go get golang.org/x/sys 2>&1
RUN go get golang.org/x/crypto 2>&1
RUN go get golang.org/x/text 2>&1
RUN go get golang.org/x/net 2>&1
