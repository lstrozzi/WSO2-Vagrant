ANALYTICS="false"

PROVISION="Configure Analytics on API Manager: " $ANALYTICS
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

# applying configuration changes to WSO2 AM-ANALYTICS
echo "Applying api-manager.xml <Analytics>"$ANALYTICS"</Analytics>"
XMLFILE=/opt/wso2/wso2am/repository/conf/api-manager.xml
cp $XMLFILE $XMLFILE.orig
xmlstarlet ed -P -u //Analytics/Enabled -v $ANALYTICS $XMLFILE.orig >$XMLFILE

# echo "Applying log4j.properties log4j.rootLogger"
# SEDFILE=/opt/wso2/wso2am/repository/conf/log4j.properties
# sed -i 's:, ERROR_LOGFILE:, ERROR_LOGFILE, DAS_AGENT:' $SEDFILE



echo "**************************************************** Provisioning '"$PROVISION"' is finished."
