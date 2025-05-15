#!/bin/bash

echo "all variables passed in the script $@"
echo "number of variables passed in the script $#"
echo "script name $0"
echo "current working directory $PWD"
echo "home directory of current user $HOME"
echo "process id of current excecuting script $$"
sleep 100 &
echo "PID of last backround command: $!"


