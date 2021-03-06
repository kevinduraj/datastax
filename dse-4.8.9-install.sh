#!/bin/bash
#----------------------------------------------------------------------------------------------------------#
# Customize Node Number and password 
#----------------------------------------------------------------------------------------------------------#
NODE=1
export PASSWORD='password'
#----------------------------------------------------------------------------------------------------------#
export NODE_RING=`expr $NODE - 1`
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
cluster="Cassandra Cluster"
data_center='DC1'
seeds="172.30.0.125,172.30.0.126,172.30.0.127,172.30.0.128,172.30.0.129"
#----------------------------------------------------------------------------------------------------------#
# Clean Data Directories
#----------------------------------------------------------------------------------------------------------#
rm -fR /cassandra/*
rm -fR /var/log/cassandra
ln -s /cassandra/ /var/lib/
chown -R cassandra:cassandra /var/lib/cassandra
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
# Cassandra Full Installation:
#----------------------------------------------------------------------------------------------------------#
yum -y install dse-full-4.8.9-1
echo "stomp_interface: ${OPSCENTER}" | tee -a /var/lib/datastax-agent/conf/address.yaml

#----------------------------------------------------------------------------------------------------------#
# Memory: https://tobert.github.io/pages/als-cassandra-21-tuning-guide.html
#----------------------------------------------------------------------------------------------------------#
sed -i 's/#MAX_HEAP_SIZE="4G"/MAX_HEAP_SIZE="12G"/' /etc/dse/cassandra/cassandra-env.sh
sed -i 's/#HEAP_NEWSIZE="800M"/HEAP_NEWSIZE="4G"/' /etc/dse/cassandra/cassandra-env.sh

#----------------------------------------------------------------------------------------------------------#
# Defaults: 
#----------------------------------------------------------------------------------------------------------#
sed -i 's/SPARK_ENABLED=0/SPARK_ENABLED=1/' /etc/default/dse
sed -i "s/Test Cluster/$cluster/" /etc/dse/cassandra/cassandra.yaml
token=${node5[$NODE_RING]}
sed -i "s/# initial_token:/initial_token: $token/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/127.0.0.1/$seeds/" /etc/dse/cassandra/cassandra.yaml
sed -i 's/com.datastax.bdp.snitch.DseSimpleSnitch/GossipingPropertyFileSnitch/' /etc/dse/cassandra/cassandra.yaml
sed -i "s/localhost/$PRIVATE_IP/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/dc1/$data_center/" /etc/dse/cassandra/cassandra-rackdc.properties

#----------------------------------------------------------------------------------------------------------#
# Add Cassanra Aliases
#----------------------------------------------------------------------------------------------------------#
cat <<EOM >> ~/.bash_aliases
alias vi='vim'
alias cqlsh='cqlsh $(hostname -I)'                                                                                                                                                                                           
alias log1='tail -100f /var/log/cassandra/output.log'
alias log2='tail -100f /var/log/cassandra/system.log'
alias dser='service dse restart && service datastax-agent restart'
EOM

#----------------------------------------------------------------------------------------------------------#
# Start All Services
#----------------------------------------------------------------------------------------------------------#
service dse start
systemctl enable datastax-agent.service
service datastax-agent start

# systemctl start datastax-agent.service
# systemctl stop datastax-agent.service
# systemctl restart datastax-agent.service
# systemctl disable datastax-agent.service
