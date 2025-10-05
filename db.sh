
#!/bin/bash


source ./common.sh
check_root

echo "Please enter DB password:"
read mysql_root_password
# read -s mysql_root_password


dnf install mysql-server -y
systemctl enable mysqld
systemctl start mysqld


mysql_secure_installation --set-root-pass ExpenseApp@1
# VALIDATE $? "mysql settingup password is :: "


# mysql_secure_installation --set-root-pass $PASSWORD
# VALIDATE $? "mysql settingup password is :: "


mysql -h db.kithusdairy.fun -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    #VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi


echo -e $G" ************ Mysql installation is going Good ************"$N


