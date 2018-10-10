#kafka broker image for HDF-3.2
#Author: Ji Chen
#Date: Sep.22th 2018
#Version: 0.2

FROM base-image/hdf3.2:v0.1

RUN yum install kafka* -y && yum clean all && rm -rf /var/cache/yum

RUN groupadd hadoop
RUN usermod -a -G hadoop kafka

VOLUME /kafka-data

ADD conf/kafka-env.sh /etc/kafka/conf/kafka-env.sh
ADD conf/server.properties /etc/kafka/conf/server.properties
ADD conf/preinit.sh /etc/kafka/conf/preinit.sh

RUN chmod +x /etc/kafka/conf/kafka-env.sh
RUN chmod +x /etc/kafka/conf/preinit.sh

RUN chgrp -R 0 /var/run/kafka && chmod -R g=u /var/run/kafka
RUN chgrp -R 0 /var/log/kafka && chmod -R g=u /var/log/kafka
RUN chgrp -R 0 /kafka-data && chmod -R g=u /kafka-data
LABEL io.openshift.tags   poc_cluster,kafka,hdf

EXPOSE 9092
USER 1001
ENTRYPOINT source /etc/kafka/conf/preinit.sh;source /usr/hdf/current/kafka-broker/config/kafka-env.sh;/usr/hdf/current/kafka-broker/bin/kafka start;tail -f /dev/null
