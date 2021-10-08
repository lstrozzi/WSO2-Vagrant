OFFSET=0
VERSION=2.6.0
PROVISION="WSO2 API-M Analytics -- Offset "$OFFSET
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# downloading from WSO2 repository circumventing the required credentials
# https://product-dist.wso2.com/products/api-manager/2.6.0/wso2am-analytics-2.6.0.zip
FILE=wso2am-analytics-$VERSION
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


# finalization, directory permissions
echo "Finalizing configuration..."	
sudo chown -R vagrant: /opt/wso2/	
if [ ! -d /etc/.java/ ]; then
   sudo mkdir /etc/.java/
   sudo mkdir /etc/.java/.systemPrefs
   sudo chown -R vagrant: /etc/.java/.systemPrefs
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
