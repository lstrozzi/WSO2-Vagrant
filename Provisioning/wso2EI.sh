#!/bin/sh

PROVISION="WSO2 Enterprise Integrator"
echo "****************************************************Provisioning '"$PROVISION"' is starting..."


# create the directory for wso2	
FILE=/opt/wso2
if [ ! -d $FILE ]; then
    echo "Creating /opt/wso2 directory..."
    sudo mkdir /opt/wso2
fi

# downloading from WSO2 repository circumventing the required credentials
VERSION=6.4.0
FILE=wso2ei-$VERSION

if [ ! -f $FILE.zip ]; then
   echo "Downloading " $FILE.zip "..."
   sudo wget -q --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" https://product-dist.wso2.com/products/enterprise-integrator/$VERSION/$FILE.zip
   echo "Unzipping " $FILE.zip " into /opt/wso2..."
   sudo unzip -q -o $FILE.zip -d /opt/wso2
   ln -s /opt/wso2/$FILE /opt/wso2/wso2ei
else
   echo $FILE.zip " already exists."
fi

# finalization, directory permissions
echo "Finalizing configuration..."
if [ ! -d /etc/.java/ ]; then
   sudo mkdir /etc/.java/
   sudo mkdir /etc/.java/.systemPrefs
   sudo chown -R vagrant: /etc/.java/.systemPrefs
fi


echo "****************************************************Provisioning '"$PROVISION"' is finished."
