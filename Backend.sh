#!/bin/bash

user=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
scriptname=$( echo $0 | cut -d "." -f1)
logfile=/tmp/$scriptname-$timestamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


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


dnf module disable nodejs -y &>>logfile
validate $? "Disabling nodejs"

dnf module enable nodejs:20 -y &>>logfile
validate $? "Enabling nodejs:20"

dnf install nodejs -y &>>logfile
validate $? "Installing nodejs"

useradd expense &>>logfile
validate $? "User is added"



