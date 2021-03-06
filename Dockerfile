FROM jenkins/slave:3.26-1-alpine
MAINTAINER Oleg Nenashev <o.v.nenashev@gmail.com>
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="3.23"
USER root

RUN apk upgrade
RUN apk add redis
RUN apk add maven
RUN apk add gawk
RUN apk add curl
RUN apk add docker
RUN apk add python
RUN apk add py-pip
RUN pip install awscli
RUN apk add nodejs
RUN apk add npm
RUN npm install newman --global
RUN apk add php
RUN apk add php-curl
RUN apk add php-json

RUN git clone https://github.com/phacility/libphutil.git /libphutil
RUN git clone https://github.com/phacility/arcanist.git /arcanist

COPY settings.xml /usr/share/java/maven-3/conf/
COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY docker-java-home /usr/local/bin/docker-java-home
COPY version.py  /usr/local/bin/
COPY values_prod.py  /usr/local/bin/
COPY values_canary.py  /usr/local/bin/
COPY values_dev.py  /usr/local/bin/
COPY staging_values.py  /usr/local/bin/
RUN chmod 755 /usr/local/bin/version.py 
RUN chmod 755 /usr/local/bin/values_prod.py 
RUN chmod 755 /usr/local/bin/values_canary.py 
RUN chmod 755 /usr/local/bin/values_dev.py 
RUN chmod 755 /usr/local/bin/staging_values.py 

ENTRYPOINT ["jenkins-slave"]
