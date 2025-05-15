#!/bin/bash

LOGS_FOLDER="/var/log/shell-scrpit"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER


USERID=$(id -u)
R="\e[31m]"
G="\e[32m]"
N="\e[0m]"
Y="\e[33m]"

echo "user id is: $USERID"


Validate(){
    if [$1 -ne 0 ]
    then
        echo -e "$2 is... $R failed $N"
        exit 1
    else
        echo -e "$2 is... $G success $N"
    fi
}

USAGE(){
    echo " $R Usage: $N sudo sh 16-redirectors.sh package 1 package 2 ...."
    exit 1
}

if [ $# -eq 0 ]
then
    USAGE
fi

echo "start date and time of the script: $(date)" | tee -a $LOG_FILE

if [ USERID -ne 0 ]
then
    echo " $R run the script with admin rights $N" | tee -a $LOG_FILE
    exit 1
fi

for package in $@ # refers to all arguments passed to it
do
   dnf list installed $package | xtee -a $LOG_FILE
   if [ $? -ne 0 ]
   then
        echo "$package is not installed, installing now" | tee -a $LOG_FILE
        dnf install $package -y
        Validate $? "installing $package"
    else
        echo "$package is already $Y installed" | tee -a $LOG_FILE $N
    fi

done