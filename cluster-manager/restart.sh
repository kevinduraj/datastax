#!/bin/bash

for node in node0 node1 node2 node3 node4 node5_ext node6_ext node7_ext node8_ext;
do
  echo $node
  ssh $node service dse restart 
  ssh $node service datastax-agent restart
  ssh $node service opscenterd restart
done

