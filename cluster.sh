#!/bin/bash
#---------------------------------------------------------#
ACTION='stop'
#---------------------------------------------------------#
if [ $# -eq 0 ]; then
   echo "Stopping cluster"
   sleep 1
else 
   echo "Starting cluster"
   ACTION='start'
   sleep 1;

fi

#---------------------------------------------------------#
for node in 192.168.1.133 192.168.1.132 192.168.1.159;
do
  echo $node
  ssh $node service dse ${ACTION} 
done

#---------------------------------------------------------#
