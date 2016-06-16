#!/bin/bash
#----------------------------------------------------------------------------------------------------------#
export NODE_NUMBER=0
export PASSWORD='hello'
export EMAIL='kduraj%40gmail.com'
export PRIVATE_IP=$(hostname -I | awk '{print $1}')
#----------------------------------------------------------------------------------------------------------#
declare -a node3=('-9223372036854775808', '-3074457345618258603', '3074457345618258602')
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
#----------------------------------------------------------------------------------------------------------#
# Installation:
#----------------------------------------------------------------------------------------------------------#
yum -y upgrade
yum -y install dse-full

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
token=${node3[$NODE_NUMBER]}
sed -i "s/# initial_token:/initial_token: $token/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/127.0.0.1/$seeds/" /etc/dse/cassandra/cassandra.yaml
sed -i 's/com.datastax.bdp.snitch.DseSimpleSnitch/GossipingPropertyFileSnitch/' /etc/dse/cassandra/cassandra.yaml
sed -i "s/localhost/$PRIVATE_IP/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/dc1/$data_center/" /etc/dse/cassandra/cassandra-rackdc.properties 
#----------------------------------------------------------------------------------------------------------#
# Optional: Move Cassandra Data into a different directories 
#----------------------------------------------------------------------------------------------------------#
#mv -f /var/lib/cassandra /mnt
#ln -s /mnt/cassandra/ /var/lib/
#chown -R cassandra:cassandra /var/lib/cassandra
#----------------------------------------------------------------------------------------------------------#
# Optional: Bash Settings
#----------------------------------------------------------------------------------------------------------#
# cat <<EOM >> ~/.bashrc 
# export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 2)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"                                                                                       
# 
# alias vi='vim'
# alias cqlsh='cqlsh $(hostname -I)'
# alias log='tail -50f /var/log/cassandra/output.log'
# EOM
#----------------------------------------------------------------------------------------------------------#
#source  ~/.bashrc
#service dse start
#tail -50f /var/log/cassandra/output.log
#----------------------------------------------------------------------------------------------------------#
# Tokenizer Calculator: 
#----------------------------------------------------------------------------------------------------------#
# wget https://raw.githubusercontent.com/kevinduraj/dse48-centos-install/master/install-dse48.sh 
# python -c 'print [str(((2**64 / 3) * i) - 2**63) for i in range(3)]'
# ctool info DSE50 | grep "private hostname"
#----------------------------------------------------------------------------------------------------------#

