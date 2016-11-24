FROM alpine:edge

MAINTAINER Chuanjian Wang <me@ckeyer.com>

RUN apk add --update rocksdb-dev sqlite-dev --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing && \
	apk add --update snappy-dev zlib-dev libbz2 git wget vim go make gcc g++ nodejs && \
	rm -rf /var/cache/apk/*

ENV GOPATH=/opt/gopath
ENV PATH=$PATH:$GOPATH/bin
ENV BRANCH=master

RUN git clone https://github.com/ckeyer/fabric.git -b $BRANCH $GOPATH/src/github.com/hyperledger/fabric && \
	cd $GOPATH/src/github.com/hyperledger/fabric/ && \
	go build -o $GOPATH/bin/peer ./peer/main.go && \
	go build -o $GOPATH/bin/obc-ca ./membersrvc/server.go 

ENV PEER_CFG_PATH=$GOPATH/bin

COPY conf/ $PEER_CFG_PATH

WORKDIR  $GOPATH/bin

ENTRYPOINT ["./peer", "node", "start"]
