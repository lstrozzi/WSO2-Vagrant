OFFSET=3
PROVISION="WSO2 Application Server -- Offset "$OFFSET
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# create the directory for wso2	
FILE=/opt/wso2
if [ ! -d $FILE ]; then
    echo "Creating /opt/wso2 directory..."
    sudo mkdir /opt/wso2
fi

# downloading from WSO2 repository circumventing the required credentials
FILE=wso2as-5.3.0
FILEZIP=$FILE.zip
if [ ! -f $FILEZIP ]; then
   echo "Downloading " $FILEZIP "..."
   sudo wget -q --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" https://product-dist.wso2.com/products/application-server/5.3.0/wso2as-5.3.0.zip
   echo "Unzipping " $FILEZIP " into /opt/wso2..."
   sudo unzip -q -o $FILEZIP -d /opt/wso2
   ln -s /opt/wso2/$FILE /opt/wso2/wso2as
else
   echo $FILEZIP " already exists."
fi

# applying offset
echo "Applying <Offset>"$OFFSET"</Offset>"
SEDFILE=/opt/wso2/$FILE/repository/conf/carbon.xml
sed -i 's:<Offset>[0-9]</Offset>:<Offset>'$OFFSET'</Offset>:' $SEDFILE

# finalization, directory permissions
echo "Finalizing configuration..."
if [ ! -d /etc/.java/ ]; then
   sudo mkdir /etc/.java/
   sudo mkdir /etc/.java/.systemPrefs
   sudo chown -R vagrant: /etc/.java/.systemPrefs
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
