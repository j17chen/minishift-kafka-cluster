#base image for HDF-3.2
#Author: Ji Chen
#Date: Sep.22th 2018
#docker build . -t base-image/hdf3.2:0.1
#Version: 0.2

FROM openshift/base-centos7
MAINTAINER Hortonworks
RUN yum install epel-release -y && yum clean all
RUN yum install -y make openssl tar git curl bind-utils unzip wget which initscripts java-1.8.0-openjdk net-tools && yum clean all && rm -rf /var/cache/yum

ADD hdf.repo /etc/yum.repos.d/

RUN yum install zookeeper* -y && yum clean all && rm -rf /var/cache/yum

