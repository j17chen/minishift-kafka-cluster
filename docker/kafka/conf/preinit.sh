
KAFKA_SERVER_CFG="/etc/kafka/conf/server.properties"
if [ $(cat $KAFKA_SERVER_CFG | grep "zookeeper.connect=MY_ZOOKEEPER_QUORUM"| wc -l) == 1 ];then
	echo "Initialize quorum settings...";
	MY_ZK_QUORUM="${ZOOKEEPER_INSTANCE_NAME}-0.${ZOOKEEPER_INSTANCE_NAME}.${MY_POD_NAMESPACE}.${MY_DOMAIN_NAME}:2181";
	for i in $(seq 2 1 ${ZOOKEEPER_INSTANCE_COUNT});do
		HOSTID=$[ $i - 1];
		SERVER_DATA="${ZOOKEEPER_INSTANCE_NAME}-${HOSTID}.${ZOOKEEPER_INSTANCE_NAME}.${MY_POD_NAMESPACE}.${MY_DOMAIN_NAME}:2181"
		MY_ZK_QUORUM=${MY_ZK_QUORUM},${SERVER_DATA}
	done
	echo "ZK quorum : ${MY_ZK_QUORUM}"
	sed -i "s/zookeeper.connect=MY_ZOOKEEPER_QUORUM/zookeeper.connect=${MY_ZK_QUORUM}/g" $KAFKA_SERVER_CFG
fi 

ZK_QUORUM=$(cat /etc/kafka/conf/server.properties | grep "zookeeper.connect=" | awk -F = '{print $2}')
echo "Waitting ZK_QUORUM $ZK_QUORUM ready..."
until /usr/hdf/current/zookeeper-client/bin/zkCli.sh -server $ZK_QUORUM ls / &> /dev/null;do echo -n ".";sleep 1;done;
echo "Done"