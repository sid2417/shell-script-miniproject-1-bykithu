#!/bin/bash


source ./common.sh
check_root

# echo "Please Enter Your Mysql Password : "

# read -s PASSWORD

echo "Please enter DB password:"
read -s mysql_root_password


dnf module disable nodejs -y &>>$LOGFILE

dnf module enable nodejs:20 -y &>>$LOGFILE

dnf install nodejs -y &>>$LOGFILE

id expense &>>$LOGFILE
if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else
    echo -e "Expense user already created...$Y SKIPPING $N"
fi

mkdir -p /app &>>$LOGFILE

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE


npm install &>>$LOGFILE


# /home/ec2-user/shell-script-miniproject-1-bykithu/backend.service
#check your repo and path

cp /home/ec2-user/shell-script-miniproject-1-bykithu/backend.service /etc/systemd/system/backend.service &>>$LOGFILE

systemctl daemon-reload &>>$LOGFILE

systemctl start backend &>>$LOGFILE

systemctl enable backend &>>$LOGFILE

dnf install mysql -y &>>$LOGFILE

mysql -h db.kithusdairy.fun -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE

systemctl restart backend &>>$LOGFILE
