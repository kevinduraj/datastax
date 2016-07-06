#!/bin/bash                                                                                                                                                                                                                            
#------------------------------------------------------------------------------#
action='start'
IP="172.30.0.125 172.30.0.126 172.30.0.127 172.30.0.128 172.30.0.129"
#------------------------------------------------------------------------------#

for node in $IP
do 
  echo $node
  ssh $node service dse $action
  ssh $node service datastax-agent $action 
  ssh $node service opscenterd $action

  #ssh $node rm -fR /cassandra/*
done

#-------------------------------------------------------------------------------
