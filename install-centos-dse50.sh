#!/bin/bash
#----------------------------------------------------------------------------------------------------------#
export PASSWORD='hello'
export NODE_NUMBER=0
#----------------------------------------------------------------------------------------------------------#
declare -a node5=('-9223372036854775808' '-5534023222112865485' '-1844674407370955162' '1844674407370955161' '5534023222112865484')
#----------------------------------------------------------------------------------------------------------#
cluster="DSE 5.0"
data_center='dc2'
seeds="172.31.13.8,172.31.13.238,172.31.8.100,172.31.2.146,172.31.8.4,172.31.1.220"

#----------------------------------------------------------------------------------------------------------#
yum -y install mlocate
yum -y install telnet
yum -y install tree
yum -y install vim-enhanced

#----------------------------------------------------------------------------------------------------------#
cat <<EOM >> ~/.bashrc 
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 2)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"                                                                                       

alias vi='vim'
alias cqlsh='cqlsh $(hostname -I)'
alias log='tail -50f /var/log/cassandra/output.log'
EOM

#----------------------------------------------------------------------------------------------------------#
/bin/cat <<EOM > /etc/yum.repos.d/datastax-eap.repo
[datastax]
name = DataStax Repo for DataStax Enterprise EAP
baseurl=https://kevin.duraj%40datastax.com:$PASSWORD@eap-downloads.datastax.com/dse/5.0.0-eap4/rpm/enterprise
enabled=1
gpgcheck=0
EOM
#----------------------------------------------------------------------------------------------------------#

yum -y upgrade
#yum remove dse-*
#yum clean all
yum -y install dse-full-5.0.0-1
rm -f /etc/yum.repos.d/datastax-eap.repo

#----------------------------------------------------------------------------------------------------------#
mv -f /var/lib/cassandra /mnt
ln -s /mnt/cassandra/ /var/lib/
chown -R cassandra:cassandra /var/lib/cassandra
#----------------------------------------------------------------------------------------------------------#
#                                     Modify casandra.yaml
#----------------------------------------------------------------------------------------------------------#

sed -i "s/Test Cluster/$cluster/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/dc1/$data_center/" /etc/dse/cassandra/cassandra-rackdc.properties 
token=${node5[$NODE_NUMBER]}
sed -i "s/# initial_token:/initial_token: $token/" /etc/dse/cassandra/cassandra.yaml
sed -i "s/127.0.0.1/$seeds/" /etc/dse/cassandra/cassandra.yaml
sed -i 's/com.datastax.bdp.snitch.DseSimpleSnitch/GossipingPropertyFileSnitch/' /etc/dse/cassandra/cassandra.yaml
ip=$(hostname -I)
sed -i "s/localhost/$ip/" /etc/dse/cassandra/cassandra.yaml

source  ~/.bashrc
#----------------------------------------------------------------------------------------------------------#
service dse start
tail -50f /var/log/cassandra/output.log

#----------------------------------------------------------------------------------------------------------#
#                                   End 
#----------------------------------------------------------------------------------------------------------#
# wget https://raw.githubusercontent.com/kevinduraj/cassandra-3.0/master/centos/install-dse5.sh 
# python -c 'print [str(((2**64 / 5) * i) - 2**63) for i in range(5)]'
# ctool info DSE50 | grep "private hostname"
#----------------------------------------------------------------------------------------------------------#

