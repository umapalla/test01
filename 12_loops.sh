#!/bin/bash
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

for package in $@ # refers to all arguments passed to it
do
   dnf list installed $package
   if [ $? -ne 0 ]
   then
        echo "$package is not installed, installing now"
        dnf install $package -y
        Validate $? "installing $package"
    else
        echo "$package is already installed"
    fi

done


# logs are very important

#example ls -l > output.txt by default it logs only success 

#ls -l &>>output.txt