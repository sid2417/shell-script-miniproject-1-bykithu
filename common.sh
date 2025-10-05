#!/bin/bash

set -e
handle_error() {
    echo "Error occured at line number: $1 , error command: $2 "
}
trap 'handle_error ${LINENO} "${BASH_COMMAND}"' ERR

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

USER=$(id -u)
if [ $? -ne 0 ]
then
    echo -e $R" Please provide the root access to the user .."$N
    exit 4
else
    echo -e $G" you have already root access .... "$N
fi

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}
