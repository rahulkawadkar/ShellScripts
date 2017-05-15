#!/bin/sh

SERVICE_NAME=HygieiaAPI
PATH_TO_JAR=/u01/app/plugin/Hygieia/api/target/api.jar
PID_PATH_NAME=/u01/app/Scripts/HygieiaAPI-pid

echo "$SERVICE_NAME ..."
case $1 in
     start)
         echo "Starting $SERVICE_NAME ..."
         if [ ! -f $PID_PATH_NAME ]; then
            nohup java -jar $PATH_TO_JAR --spring.config.location=dashboard.properties /tmp 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is already running exiting shell..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stoping ..."
            kill $PID;
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running...."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            nohup java -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac
