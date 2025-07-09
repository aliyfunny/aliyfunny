监控主机的磁盘空间,当使用空间超过90％就通过发mail来发警告
#!/bin/bash
#monitor available disk space
#提取本服务器的IP地址信息
IP=`ifconfig eth0 | grep "inet addr" | cut -f 2 -d ":" | cut -f 1 -d " "`
SPACE=` df -hP | awk '{print int($5)}'`
if [ $SPACE -ge 90 ]
then
echo "$IP 服务器 磁盘空间 使用率已经超过90%，请及时处理。"|mail -s "$IP 服务器硬盘告警，公众号：网络技术干货圈" fty89@163.com
fi
