#!/bin/bash
#---------------------------------------------------------------------------#
export PASSWORD='password'
export EMAIL='kduraj%40gmail.com'
#---------------------------------------------------------------------------#
# DataStax Community 
#---------------------------------------------------------------------------#
# rm -f /etc/yum.repos.d/datastax*
# /bin/cat <<EOM > /etc/yum.repos.d/datastax.repo
# [opscenter]
# name = DataStax Repo for Apache Cassandra
# baseurl = http://rpm.datastax.com/community
# enabled = 1
# gpgcheck = 0
# EOM
#---------------------------------------------------------------------------#
# DataStax Enterprise
#---------------------------------------------------------------------------#
/bin/cat <<EOM >> /etc/yum.repos.d/datastax.repo
[opscenter]
name = DataStax Repo for DataStax Enterprise
baseurl=https://$EMAIL:$PASSWORD@rpm.datastax.com/enterprise
enabled=1
gpgcheck=0
EOM
#---------------------------------------------------------------------------#
yum install opscenter
#---------------------------------------------------------------------------#

