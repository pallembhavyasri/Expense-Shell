#!/bin/bash

user=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
scriptname=$( echo $0 | cut -d "." -f1)
logfile=/tmp/$scriptname-$timestamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate()
{
    if [ $1 -eq 0 ]
        echo -e "$G $2...Success $N"
    else
        echo -e "$R $2---Failure $N"
}

if [ $user -eq 0 ] 
then    
    echo -e "user is having $G root access $N" 
else
    echo -e " $R Run with root access $N"
    exit 1
if

dnf install mysql-server -y &>>$logfile 
validate $? "Installing Mysql"

dnf enable mysqld -y &>>$logfile
validate $? "Enabling mysql"

dnf start mysqld -y &>>$logfile
validate $? "Starting Mysql"

mysql_secure_installation --set-root-pass B@bbi!234 &>>$logfile
validate $? "setting up root password"