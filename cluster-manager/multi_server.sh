#!/bin/bash

for node in node0 node1 node2 node3 node4 node5_ext node6_ext node7_ext node8_ext;
do
  echo $node
  ssh $node nodetool cleanup 
  ssh $node nodetool repair
  ssh $node nodetool status
done

