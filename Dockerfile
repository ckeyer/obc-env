FROM centos:7

MAINTAINER Chuanjian Wang <me@ckeyer.com>

ENV GOPATH=/opt/gopath

RUN yum install -y make gcc gcc-c++ snappy snappy-devel zlib zlib-devel bzip2 bzip2-devel unzip wget 

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
