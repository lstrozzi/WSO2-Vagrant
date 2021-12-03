#!/usr/bin/env bash
PROVISION="Configuring WSO2 API Manager "
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

NEWHOSTNAME=192.168.56.13
# Changing HostName
echo "Changing HostName t: " $NEWHOSTNAME
XMLFILE=/opt/wso2/wso2am/repository/conf/carbon.xml
sed -i 's:<HostName>localhost</HostName>:<HostName>'$NEWHOSTNAME'</HostName>:' $XMLFILE
sed -i 's:<MgtHostName>localhost</MgtHostName>:<MgtHostName>'$NEWHOSTNAME'</MgtHostName>:' $XMLFILE
grep HostName $XMLFILE
XMLFILE=/opt/wso2/wso2am/repository/conf/api-manager.xml
sed -i 's:<HostName>.*</HostName>:<HostName>'$NEWHOSTNAME'</HostName>:' $XMLFILE
grep HostName $XMLFILE
