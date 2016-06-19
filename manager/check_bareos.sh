#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

pass() {
  echo -e "[${GREEN}Pass${NC}]" 
}

fail() {
  echo -e "[${RED}Fail${NC}]" 
}

warn () {
  echo -e "[${YELLOW}$1${NC}]" 
}

echo -n "Swap is off                 "
if ! swapon -s | grep -q swapfile ; then pass 
else 
  fail 
fi


echo -n "NTP is working              "
if ntpstat | grep -q synchroni ; then pass  ; else fail ; fi 

echo -n "Oracle Java is installed    "
if java -version 2>&1 | grep -q "openjdk.*1.8" ; then warn "OpenJDK 8" 
elif java -version 2>&1 | grep -q "Java(TM).*1.8" ; then pass  ; else fail ; fi

echo -n "EPEL Repo in installed      "
if yum list installed epel* >/dev/null 2>&1 ; then pass ;  else fail; fi

echo -n "DSE is installed            " 
if dse -v > /dev/null 2>&1; then pass  ; else fail ; fi

echo -n "Use Both Disks              " 
if [ `mount | grep -v none | wc -l` -gt 2 ]; then pass ;
elif [ `mount | grep -v none | wc -l` -gt 1 ]; then warn "Only 1 Extra";
 else fail ; fi

CASS_CONF=$(echo 'import os; print os.environ["CASSANDRA_CONF"]' | dse pyspark)
YAML=$CASS_CONF/cassandra.yaml

DATA_DIR=$(sed -n '/data_file_dir/ {n; s/.*- *//;p}' $YAML)
COMMIT_DIR=$(sed -n '/^\w*commitlog_directory/ {s/.* "*\([^ "]*\)"*/\1/;p}' $YAML)
SNITCH=$(sed -n '/^\w*endpoint_snitch/ {s/.* //;p}' $YAML)
RPC=$(sed -n '/^\w*rpc_address/ {s/.* //;p}' $YAML)

DATA_DEV=$(df $DATA_DIR | sed -n '2 {s/ .*//;p}')
COMMIT_DEV=$(df $COMMIT_DIR | sed -n '2 {s/ .*//;p}')

echo -n "Data Directory not on root  "
if [ $DATA_DEV != '/dev/xvda' ] ; then pass  ; else fail ; fi

echo    "Commit Directory not on root"
echo -n " and is on separate disk    "
if [ $COMMIT_DEV != '/dev/xvda'  ] && [ $COMMIT_DEV != $DATA_DEV ]  ; then pass  ; else fail ; fi

echo -n "Blockdev setra is 128       "
if [ $(blockdev --report $DATA_DEV | sed -n '2 {s/\w* *\(\w*\)  *.*/\1/; p}') -eq 128 ]; then pass ; else fail ; fi

echo -n "Snitch is not Simple        "
if  [ -f $YAML ] && grep -q -i 'simple' <<<$SNITCH  ; then fail  ; else pass ; fi

echo -n "More than one seed          "
if grep -q 'seeds:.*,' $YAML; then pass; else fail ; fi

echo -n "Cluster has minimum 3 nodes "
if [ $(nodetool status | grep ^UN | wc -l) -ge 3 ]; then pass; else fail; fi

echo -n "Cassandra-stress was run    "
if echo "select keyspace_name from system.schema_keyspaces where keyspace_name = 'keyspace1';" | cqlsh `hostname -i` | grep -q 'keyspace1'; then pass ; else fail; fi


