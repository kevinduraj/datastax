#!/bin/bash
#-------------------------------------------------------------------------------------------#
yum -y remove dse
rm -fR /etc/dse
rm -fR /usr/share/dse
rm -f /etc/default/dse*
rm -fR /usr/share/doc/dse-lib*
rm -fR /usr/share/opscenter
rm -fR /etc/opscenter
rm -f /etc/rc.d/rc0.d/*dse
#-------------------------------------------------------------------------------------------#
# Remove DataStax Agent for DSE 5.0
#-------------------------------------------------------------------------------------------#

rm -fR /usr/share/datastax-agent
rm -fR /var/lib/datastax-agent
rm -fR /etc/datastax-agent
rm -fR /usr/share/doc/datastax-agent
rm -fR /var/log/datastax-agent
rm -f /etc/yum.repos.d/datastax.repo
#-------------------------------------------------------------------------------------------#
# Remove Services for DSE 5.0
#-------------------------------------------------------------------------------------------#
rm -f /etc/rc.d/rc0.d/K05datastax-agent /etc/rc.d/rc0.d/K05opscenterd
rm -f /etc/rc.d/rc1.d/K50dse /etc/rc.d/rc1.d/K05datastax-agent /etc/rc.d/rc1.d/K05opscenterd
rm -f /etc/rc.d/rc2.d/S50dse /etc/rc.d/rc2.d/S80datastax-agent /etc/rc.d/rc2.d/S80opscenterd
rm -f /etc/rc.d/rc3.d/S50dse /etc/rc.d/rc3.d/S80datastax-agent /etc/rc.d/rc3.d/S80opscenterd
rm -f /etc/rc.d/rc4.d/S50dse /etc/rc.d/rc4.d/S80datastax-agent /etc/rc.d/rc4.d/S80opscenterd
rm -f /etc/rc.d/rc5.d/S50dse /etc/rc.d/rc5.d/S80datastax-agent /etc/rc.d/rc5.d/S80opscenterd
rm -f /etc/rc.d/rc6.d/K50dse /etc/rc.d/rc6.d/K05datastax-agent /etc/rc.d/rc6.d/K05opscenterd
#-------------------------------------------------------------------------------------------#
