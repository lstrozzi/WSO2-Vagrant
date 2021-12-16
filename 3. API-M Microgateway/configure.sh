#!/usr/bin/env bash
PROVISION="Configuring WSO2 API Manager"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

NEWHOSTNAME=192.168.56.12

# Changing HostName
echo "* Changing HostName to: " $NEWHOSTNAME

XMLFILE=/opt/wso2/wso2am/repository/conf/carbon.xml
echo "* Updating file "$XMLFILE
sed -i 's:<HostName>.*</HostName>:<HostName>'$NEWHOSTNAME'</HostName>:' $XMLFILE
sed -i 's:<MgtHostName>.*</MgtHostName>:<MgtHostName>'$NEWHOSTNAME'</MgtHostName>:' $XMLFILE
grep HostName $XMLFILE

XMLFILE=/opt/wso2/wso2am/repository/conf/api-manager.xml
echo "* Updating file "$XMLFILE
sed -i 's:<HostName>.*</HostName>:<HostName>'$NEWHOSTNAME'</HostName>:' $XMLFILE
grep HostName $XMLFILE


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
