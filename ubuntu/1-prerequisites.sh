#!/bin/bash                                                                                                                                                   

#--- Install Java ---#
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer
apt-get install oracle-java8-set-default
java -version
update-alternatives --config java

#--- Install Utilities ---#
apt-get -y install mlocate
apt-get -y install vim-enhanced
apt-get -y install tree
apt-get -y install telnet

