FROM python:2

MAINTAINER Chuanjian Wang <me@ckeyer.com>

RUN curl https://bootstrap.pypa.io/get-pip.py |python

RUN cd /tmp && \
	wget -O request.tgz https://pypi.python.org/packages/2e/ad/e627446492cc374c284e82381215dcd9a0a87c4f6e90e9789afefe6da0ad/requests-2.11.1.tar.gz#md5=ad5f9c47b5c5dfdb28363ad7546b0763 && \
	tar zxvf request.tgz && \
	cd requests-2.11.1 && \
	python setup.py install && \
	rm -rf /tmp/*
