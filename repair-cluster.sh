#!/bin/bash

for node in 192.168.1.133 192.168.1.132 127.0.0.1;
do
  echo $node
  ssh $node nodetool cleanup &  
  ssh $node nodetool repair
  ssh $node nodetool status
done

