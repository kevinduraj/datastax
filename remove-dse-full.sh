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
rm -f /etc/rc.d/rc1.d/K50dse /etc/rc.d/rc1.d/K05opscenterd /etc/rc.d/rc1.d/K05datastax-agent
#-------------------------------------------------------------------------------------------#
