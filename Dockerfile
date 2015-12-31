FROM python:2
MAINTAINER Jason Sallis <jason@sall.is>

ENV VERSION 1.4.0

RUN git clone -b ${VERSION} https://github.com/openstack-infra/jenkins-job-builder.git
WORKDIR jenkins-job-builder
RUN pip install -r requirements.txt && python setup.py install
