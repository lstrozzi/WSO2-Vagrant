OFFSET=0
PROVISION="WSO2 API Manager -- Offset "$OFFSET
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# downloading from WSO2 repository circumventing the required credentials
# https://product-dist.wso2.com/products/api-manager/2.6.0/wso2am-2.6.0.zip

VERSION=4.0.0
FILEBASE=wso2am
FILE=$FILEBASE-$VERSION
FILEZIP=$FILE.zip
BASEURL=http://product-dist.wso2.com/products/api-manager
CACHEDIR=/vagrant_data/products

if [ ! -f $FILEZIP ]; then
  
   if [ ! -f $CACHEDIR/$FILEZIP ]; then
     echo "Downloading " $BASEURL/$VERSION/$FILEZIP "..."
     sudo wget -q --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" $BASEURL/$VERSION/$FILEZIP
     mv $FILEZIP $CACHEDIR/$FILEZIP
   fi
   
   ln -s $CACHEDIR/$FILEZIP $FILEZIP
else
   echo $FILEZIP " already exists."
fi

# create the directory for wso2	
if [ ! -d /opt/wso2 ]; then
   echo "Creating /opt/wso2 directory..."
   sudo mkdir /opt/wso2
fi

if [ ! -d /opt/wso2/$FILE ]; then
   echo "Unzipping " $FILEZIP " into /opt/wso2..."
   sudo unzip -q -o $FILEZIP -d /opt/wso2
   ln -s /opt/wso2/$FILE /opt/wso2/$FILEBASE
fi

# applying offset
echo "Applying <Offset>"$OFFSET"</Offset>"
SEDFILE=/opt/wso2/$FILE/repository/conf/carbon.xml
sed -i 's:<Offset>[0-9]</Offset>:<Offset>'$OFFSET'</Offset>:' $SEDFILE


# applying configuration changes to WSO2 AM-ANALYTICS
# echo "Applying api-manager.xml <Analytics>true</Analytics>"
# XMLFILE=/opt/wso2/$FILE/repository/conf/api-manager.xml
# cp $XMLFILE $XMLFILE.orig
# xmlstarlet ed -P -u //Analytics/Enabled -v true $XMLFILE.orig >$XMLFILE

# echo "Applying log4j.properties log4j.rootLogger"
# SEDFILE=/opt/wso2/$FILE/repository/conf/log4j.properties
# sed -i 's:, ERROR_LOGFILE:, ERROR_LOGFILE, DAS_AGENT:' $SEDFILE


# finalization, directory permissions
echo "Finalizing configuration..."	
sudo chown -R vagrant: /opt/wso2/	
if [ ! -d /etc/.java/ ]; then
   sudo mkdir /etc/.java/
   sudo mkdir /etc/.java/.systemPrefs
   sudo chown -R vagrant: /etc/.java/.systemPrefs
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
