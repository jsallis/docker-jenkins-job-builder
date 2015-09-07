FROM python:2
MAINTAINER Jason Sallis <jason@sall.is>

RUN git clone -b 1.3.0 https://github.com/openstack-infra/jenkins-job-builder.git
WORKDIR jenkins-job-builder
RUN pip install -r requirements.txt && python setup.py install
