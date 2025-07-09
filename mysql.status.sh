#!/bin/bash
MYSQL_USER='zabbix'
MYSQL_PWD='zabbix'
MYSQL_HOST='localhost'
MYSQL_PORT=$2
MYSQL_CONN="/usr/bin/mysqladmin -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} --socket=/data/mysql_${MYSQL_PORT}/data/mysql_${MYSQL_PORT}.sock --port=${MYSQL_PORT} "

help() {
        echo "Usage:$0  [ping|Uptime|Com_update|Slow_queries|Com_select|Com_roll
back|Questions|Com_insert|Com_delete|Com_commit|Bytes_sent|Bytes_received|Com_begin]  port"

}

if [ $# -lt "2" ];then
    echo "....!"
    help
    exit 2
fi

case $1 in
    ping)
        result=`${MYSQL_CONN} ping | grep -c alive`
        echo $result
        ;;
    Uptime)
        result=`${MYSQL_CONN} status |cut -f2 -d":"|cut -f1 -d"T"`
        echo $result
        ;;
    Com_update)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_update"|cut -d"|" -f3`
        echo $result
        ;;
    Slow_queries)
        result=`${MYSQL_CONN} status  |cut -f5 -d":"|cut -f1 -d"O"`
        echo $result
        ;;
    Com_select)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_select"|cut -d"|" -f3`
        echo $result
                ;;
    Com_rollback)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_rollback"|cut -d"|" -f3`
                echo $result
                ;;
    Questions)
        result=`${MYSQL_CONN} status  |cut -f4 -d":"|cut -f1 -d"S"`
                echo $result
                ;;
    Com_insert)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_insert"|cut -d"|" -f3`
                echo $result
                ;;
    Com_delete)
        result=`${MYSQL_CONN} extended-status  |grep -w "Com_delete"|cut -d"|" -f3`
                echo $result
                ;;
    Com_commit)
        result=`${MYSQL_CONN} extended-status  |grep -w "Com_commit"|cut -d"|" -f3`
                echo $result
                ;;
    Bytes_sent)
        result=`${MYSQL_CONN} extended-status  |grep -w "Bytes_sent"|cut -d"|" -f3`
                echo $result
                ;;
    Bytes_received)
        result=`${MYSQL_CONN} extended-status |grep -w "Bytes_received" |cut -d"|" -f3`
                echo $result
                ;;
    Com_begin)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_begin"|cut -d"|" -f3`
                echo $result
                ;;


        *)
        help
        ;;
esac
