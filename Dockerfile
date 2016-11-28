FROM ckeyer/dev:node

MAINTAINER Chuanjian Wang <me@ckeyer.com>

RUN adduser ck --disabled-password --shell=/bin/bash --system

USER ck

RUN cd /home/ck && \
	git clone https://github.com/obcpeer/blockchain-explorer

RUN cd /home/ck/blockchain-explorer/explorer_1/ && \
	npm install && \
	npm install grunt grunt-contrib-copy && \
	grunt

ENV HTTP_PORT=8080
ENV HYP_REST_ENDPOINT=http://u5.mj:7050

WORKDIR /home/ck/blockchain-explorer/explorer_1/
EXPOSE 8080

CMD ["node", "exp-server.js"]
