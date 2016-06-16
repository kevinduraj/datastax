#!/bin/bash

cassandra-stress write n=10000000 cl=one -mode native cql3 -schema keyspace="keyspace3" -log file=~/load_1M_rows.log -node 172.31.0.115

