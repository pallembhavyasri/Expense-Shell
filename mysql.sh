#!/bin/bash

user=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
scriptname=$( echo $0 | cut -d "." -f1)
logfile=/tmp/$scriptname-$timestamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"       


echo "Pls enter DB pswwd"
read -s mysql_root_password

validate(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$2...$G Success $N"
    else
        echo -e "$2...$R Failure $N"
    fi
}


if [ $user -eq 0 ] 
    then    
        echo -e "user is having $G root access $N" 
    else
        echo -e " $R Run with root access $N"
        exit 1
fi



dnf install mysql-server -y &>>$logfile 
validate $? "Installing Mysql"

systemctl enable mysqld &>>$logfile
validate $? "Enabling mysql"

systemctl start mysqld &>>$logfile
validate $? "Starting Mysql"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#validate $? "setting up root password"

#idempotency means for every run it will not consider newly once it is success and then rerun again it takes as failure
#Since before is suucess and shells cript is not idempotent

mysql -h db.bhavya.store -uroot -p${mysql_root_password} -e 'show databases;' &>>$logfile
if [ $? -eq 0 ]
then    
    echo -e "Already password setup is completed..$Y Skipping $N"
else
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$logfile
    validate $? "MYSQL Root pssword setup"
fi



