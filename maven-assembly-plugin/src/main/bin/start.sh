#!/bin/bash

echo 'prepare the project ...'


SERVER_NAME=liyang_app

cd `dirname $0`
BIN_DIR=`pwd`

cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$DEPLOY_DIR/conf
LOG_DIR=$DEPLOY_DIR/logs
LOG_FILE=$DEPLOY_DIR/logs/stdout.log

if [ ! -e $LOG_DIR ]; then
   `mkdir -p $LOG_DIR`
   `touch $LOG_FILE`
fi 



JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "
#JAVA_MEM_OPTS=" -server -Xms128k -Xmx128k -XX:PermSize=128m -XX:SurvivorRatio=2 -XX:+UseParallelGC "
LIB_DIR=$DEPLOY_DIR/lib
LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`

echo "Starting the $SERVER_NAME ..."

command="java $JAVA_OPTS   -classpath $CONF_DIR:$LIB_JARS com.liyang.maven.assembly.Bootstrap > $LOG_FILE &"
echo "$command"

nohup java $JAVA_OPTS   -classpath $CONF_DIR:$LIB_JARS com.liyang.maven.assembly.Bootstrap > $LOG_FILE &

#nohup java $JAVA_OPTS $JAVA_MEM_OPTS  -classpath $CONF_DIR:$LIB_JARS com.liyang.maven.assembly.Bootstrap > $LOG_FILE &
