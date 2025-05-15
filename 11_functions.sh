#!/bin/bash

#success - green 32M
#failed - red 31M
#33M - yello
#syntax for colour "\e[31m]"


USERID=$(id -u)
R="\e[31m]"
G="\e[32m]"
N="\e[0m]"

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

if [ USERID -ne 0 ]
then
    echo " run the script with admin rights"
    exit 1
fi

dnf list installed git

if[ $? -ne 0 ]
then
    echo "git is not installed, going to install it"
    dnf install git -y
    Validate $? "Listing Git"
else
    echo "git is already installed, nothing to do"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "mysql is not installed, going to install"
    dnf install mysql -y
    Validate $? "Listing Git"
else
    echo "My sql is already installed"
fi