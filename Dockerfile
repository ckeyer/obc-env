FROM ckeyer/obc:base

RUN git clone https://github.com/ckeyer/fabric.git -b csphere-0621 $GOPATH/src/github.com/hyperledger/fabric && \
	cd $GOPATH/src/github.com/hyperledger/fabric/ && \
	go build -o $GOPATH/bin/peer ./peer/main.go && \
	go build -o $GOPATH/bin/obc-ca ./membersrvc/server.go 

WORKDIR  $GOPATH/src/github.com/hyperledger/fabric/