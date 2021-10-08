PROVISION="WSO2 Developer Studio"
echo "****************************************************Provisioning '"$PROVISION"' is starting..."


# create the directory for wso2	
FILE=/opt/wso2
VERSION=6.4.0
if [ ! -d $FILE ]; then
    echo "Creating /opt/wso2 directory..."
    sudo mkdir /opt/wso2
fi

# downloading from WSO2 repository circumventing the required credentials
FILE=developer-studio-ei-eclipse-jee-mars-linux-gtk-x86_64-$VERSION.zip
if [ ! -f $FILE ]; then
   echo "Downloading " $FILE "..."
   sudo wget -q https://product-dist.wso2.com/products/enterprise-integrator/$VERSION/$FILE
   echo "Unzipping " $FILE " into /opt/wso2..."
   sudo mkdir /opt/wso2/devStudio
   sudo unzip -q -o $FILE -d /opt/wso2/devStudio
else
   echo $FILE " already exists."
fi

FILE=/opt/wso2/sources
if [ ! -d $FILE ]; then
   echo "**** downloading synapse-core sources..."
   sudo mkdir /opt/wso2/sources
   cd /opt/wso2/sources
   git clone -b "v2.1.17-wso2v48" https://github.com/wso2/wso2-synapse.git wso2-synapse
fi

# finalization, directory permissions
echo "Finalizing configuration..."
if [ ! -d /etc/.java/ ]; then
   sudo mkdir /etc/.java/
   sudo mkdir /etc/.java/.systemPrefs
   sudo chown -R vagrant: /etc/.java/.systemPrefs
fi


echo "****************************************************Provisioning '"$PROVISION"' is finished."
