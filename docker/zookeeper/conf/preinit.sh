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
cat /etc/zookeeper/conf/zoo.cfg | grep server. | awk -F = '{print $2}'| awk -F : '{print $1}'| while read h; do until nslookup $h ;do echo "wait $h ready...";sleep 10;done;echo "ZK host $h Is ready";done
echo "All ZK Nodes is ready"
