OFFSET=0

PROVISION="Configuring WSO2 API Manager -- Offset "$OFFSET
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

# applying offset
echo "Applying <Offset>"$OFFSET"</Offset>"
XMLFILE=/opt/wso2/wso2am/repository/conf/carbon.xml
# NOT WORKING xmlstarlet ed --inplace -P -u //Ports/Offset -v $OFFSET $XMLFILE
sed -i 's:<Offset>[0-9]</Offset>:<Offset>'$OFFSET'</Offset>:' $XMLFILE


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
