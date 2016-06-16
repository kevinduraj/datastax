#!/bin/bash
#----------------------------------------------------------------------------------------------------------#
export NODE_NUMBER=0
export PASSWORD='hello'
export EMAIL='kduraj%40gmail.com'
export PRIVATE_IP=$(hostname -I | awk '{print $1}')
#----------------------------------------------------------------------------------------------------------#
declare -a node3=('-9223372036854775808', '-3074457345618258603', '3074457345618258602')
declare -a node5=('-9223372036854775808', '-5534023222112865485', '-1844674407370955162', '1844674407370955161', '5534023222112865484')
#----------------------------------------------------------------------------------------------------------#
# Default Settings:
#----------------------------------------------------------------------------------------------------------#
cluster="Nootrino Cluster"
data_center='DC1'
seeds="192.168.1.159,192.168.1.132,192.168.1.133"

#----------------------------------------------------------------------------------------------------------#
rm -f /etc/yum.repos.d/datastax*

/bin/cat <<EOM > /etc/yum.repos.d/datastax.repo
[datastax]
name = DataStax Repo for DataStax Enterprise
baseurl=https://$EMAIL:$PASSWORD@rpm.datastax.com/enterprise
enabled=1
gpgcheck=0
EOM
#---------------------------------------------------------------------------------------------------------------#
# Installation: DataStax Enterprise 4.8
#---------------------------------------------------------------------------------------------------------------#
yum -y upgrade
yum -y install dse-full

#---------------------------------------------------------------------------------------------------------------#
# Memory: https://tobert.github.io/pages/als-cassandra-21-tuning-guide.html
#---------------------------------------------------------------------------------------------------------------#
sed -i 's/#MAX_HEAP_SIZE="4G"/MAX_HEAP_SIZE="16G"/' /etc/dse/cassandra/cassandra-env.sh
sed -i 's/#HEAP_NEWSIZE="800M"/HEAP_NEWSIZE="1G"/' /etc/dse/cassandra/cassandra-env.sh
#---------------------------------------------------------------------------------------------------------------#
# Set Defaults Settings 
#---------------------------------------------------------------------------------------------------------------#
sed -i 's/SPARK_ENABLED=0/SPARK_ENABLED=1/' /etc/default/dse
sed -i "s/Test Cluster/$cluster/" /etc/dse/cassandra/cassandra.yaml
token=${node5[$NODE_NUMBER]}
sed -i "s/# initial_token:/initial_token: $token/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/127.0.0.1/$seeds/" /etc/dse/cassandra/cassandra.yaml
sed -i 's/com.datastax.bdp.snitch.DseSimpleSnitch/GossipingPropertyFileSnitch/' /etc/dse/cassandra/cassandra.yaml
sed -i "s/localhost/$PRIVATE_IP/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/dc1/$data_center/" /etc/dse/cassandra/cassandra-rackdc.properties 
#---------------------------------------------------------------------------------------------------------------#
# Enforce Cassandra Ownership 
#---------------------------------------------------------------------------------------------------------------#
chown -R cassandra:cassandra /var/lib/cassandra



