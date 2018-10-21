ZOO_CFG="/etc/zookeeper/conf/zoo.cfg"

if [ $(grep "server." $ZOO_CFG | wc -l ) = 0 ];then
	echo "Initialize quorum settings...";
	echo >> $ZOO_CFG
	for i in $(seq 1 1 ${ZOOKEEPER_INSTANCE_COUNT});do
		HOSTID=$[ $i - 1];
		SERVER_DATA="server.${i}=${ZOOKEEPER_INSTANCE_NAME}-${HOSTID}.${ZOOKEEPER_INSTANCE_NAME}.${MY_POD_NAMESPACE}.${MY_DOMAIN_NAME}:2888:3888"
		echo $SERVER_DATA
		echo $SERVER_DATA >> $ZOO_CFG
	done
fi

if [ ! -f "/zookeeper/myid" ];then
	echo "Quorum id doesn't exist, generate Quorum id..."
	RAWID=`echo $(hostname) | awk -F - '{print $2}' `
	#echo $RAWID
	MYID=$[ $RAWID + 1 ]
	echo "New Quorum id: $MYID"
	echo $MYID > /zookeeper/myid
fi
echo "Waitting all zookeeper nodes ready..."
sleep 10
cat $ZOO_CFG | grep server. | awk -F = '{print $2}'| awk -F : '{print $1}'| while read h; do until nslookup $h ;do echo "wait $h ready...";sleep 10;done;echo "ZK host $h Is ready";done
echo "All ZK Nodes is ready"
