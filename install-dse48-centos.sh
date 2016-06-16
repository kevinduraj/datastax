#!/bin/bash
#----------------------------------------------------------------------------------------------------------#
export NODE_NUMBER=0                                                                                                                                                                                                                    
export PASSWORD='password'
export EMAIL='kduraj%40gmail.com'
export PRIVATE_IP=$(hostname -I | awk '{print $1}')
OPSCENTER='172.30.0.125'
#----------------------------------------------------------------------------------------------------------#
declare -a node3=('-9223372036854775808', 
                  '-3074457345618258603', 
                  '3074457345618258602')

declare -a node5=('-9223372036854775808', 
                  '-5534023222112865485', 
                  '-1844674407370955162', 
                  '1844674407370955161', 
                  '5534023222112865484')
#----------------------------------------------------------------------------------------------------------#
# Default Settings:
#----------------------------------------------------------------------------------------------------------#
cluster="ZEFR Cluster"
data_center='DC1'
seeds="172.30.0.125,172.30.0.126,172.30.0.127,172.30.0.128,172.30.0.129"

#----------------------------------------------------------------------------------------------------------#
# DataStax Community 
#----------------------------------------------------------------------------------------------------------#
# rm -f /etc/yum.repos.d/datastax*
# /bin/cat <<EOM > /etc/yum.repos.d/datastax.repo
# [datastax]
# name = DataStax Repo for Apache Cassandra
# baseurl = http://rpm.datastax.com/community
# enabled = 1
# gpgcheck = 0
# EOM
#----------------------------------------------------------------------------------------------------------#
# DataStax Enterprise
#----------------------------------------------------------------------------------------------------------#
rm -f /etc/yum.repos.d/datastax*
/bin/cat <<EOM > /etc/yum.repos.d/datastax.repo
[datastax]
name = DataStax Repo for DataStax Enterprise
baseurl=https://$EMAIL:$PASSWORD@rpm.datastax.com/enterprise
enabled=1
gpgcheck=0
EOM
#----------------------------------------------------------------------------------------------------------#
# Installation:
#----------------------------------------------------------------------------------------------------------#
yum -y upgrade
yum -y install dse-full
yum -y install datastax-agent
# echo "stomp_interface: 172.30.0.125" | tee -a /var/lib/datastax-agent/conf/address.yaml
echo "stomp_interface: ${OPSCENTER}" | tee -a /var/lib/datastax-agent/conf/address.yaml

#----------------------------------------------------------------------------------------------------------#
# Memory: https://tobert.github.io/pages/als-cassandra-21-tuning-guide.html
#----------------------------------------------------------------------------------------------------------#
sed -i 's/#MAX_HEAP_SIZE="4G"/MAX_HEAP_SIZE="16G"/' /etc/dse/cassandra/cassandra-env.sh
sed -i 's/#HEAP_NEWSIZE="800M"/HEAP_NEWSIZE="1G"/' /etc/dse/cassandra/cassandra-env.sh
#----------------------------------------------------------------------------------------------------------#
# Defaults: 
#----------------------------------------------------------------------------------------------------------#
sed -i 's/SPARK_ENABLED=0/SPARK_ENABLED=1/' /etc/default/dse
sed -i "s/Test Cluster/$cluster/" /etc/dse/cassandra/cassandra.yaml
token=${node5[$NODE_NUMBER]}
sed -i "s/# initial_token:/initial_token: $token/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/127.0.0.1/$seeds/" /etc/dse/cassandra/cassandra.yaml
sed -i 's/com.datastax.bdp.snitch.DseSimpleSnitch/GossipingPropertyFileSnitch/' /etc/dse/cassandra/cassandra.yaml
sed -i "s/localhost/$PRIVATE_IP/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/dc1/$data_center/" /etc/dse/cassandra/cassandra-rackdc.properties
#----------------------------------------------------------------------------------------------------------#
chown -R cassandra:cassandra /var/lib/cassandra
#----------------------------------------------------------------------------------------------------------#
# Add Cassanra Aliases
#----------------------------------------------------------------------------------------------------------#
cat <<EOM >> ~/.bash_aliases
alias cqlsh='cqlsh $(hostname -I)'
alias log='tail -50f /var/log/cassandra/output.log'
EOM
#----------------------------------------------------------------------------------------------------------#
