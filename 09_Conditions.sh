#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt 20 ] #gt, lt, eq, -Ne, -ge, -le
then
    echo "Given number: $NUMBER is greater than 20"
else
    echo "GivenNumber: $NUMBER is less than 20"
fi
