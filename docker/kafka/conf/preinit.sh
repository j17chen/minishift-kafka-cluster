ZK_QUORUM=$(cat /etc/kafka/conf/server.properties | grep "zookeeper.connect=" | awk -F = '{print $2}')
echo "Waitting ZK_QUORUM $ZK_QUORUM ready..."
until /usr/hdf/current/zookeeper-client/bin/zkCli.sh -server $ZK_QUORUM ls / &> /dev/null;do echo -n ".";sleep 1;done;
echo "Done"