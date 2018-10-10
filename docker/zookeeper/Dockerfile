#zookeeper container for HDF-3.2
#Author: Ji Chen
#Date: Sep.22th 2018
#docker build . -t zookeeper/hdf3.2:v0.1
#Version: 0.2

FROM base-image/hdf3.2:v0.1

RUN groupadd hadoop
RUN usermod -a -G hadoop zookeeper

VOLUME /zookeeper

ADD conf/zookeeper-env.sh /etc/zookeeper/conf/zookeeper-env.sh
ADD conf/zoo.cfg /etc/zookeeper/conf/zoo.cfg
ADD conf/preinit.sh /etc/zookeeper/conf/preinit.sh

RUN chmod +x /etc/zookeeper/conf/zookeeper-env.sh
EXPOSE 2181

RUN chgrp -R 0 /etc/zookeeper && chmod -R g=u /etc/zookeeper
RUN chgrp -R 0 /var/run/zookeeper && chmod -R g=u /var/run/zookeeper
RUN chgrp -R 0 /var/log/zookeeper && chmod -R g=u /var/log/zookeeper
RUN chgrp -R 0 /zookeeper && chmod -R g=u /zookeeper

LABEL io.openshift.tags   poc_cluster,zookeeper,hdf

ENTRYPOINT source /etc/zookeeper/conf/preinit.sh;source /usr/hdf/current/zookeeper-server/conf/zookeeper-env.sh ; env ZOOCFGDIR=/etc/zookeeper/conf /usr/hdf/current/zookeeper-server/bin/zkServer.sh start;tail -f /dev/null;


