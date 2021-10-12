PROVISION="WSO2 $1 "
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

PRODUCT=$1
VERSION=$2
FILEBASE=$3
FILE=$FILEBASE-$VERSION
FILEZIP=$FILE.zip
BASEURL=http://product-dist.wso2.com/products/$PRODUCT
CACHEDIR=/vagrant_data/products

if [ ! -d "$CACHEDIR" ]; then
   echo "Creating $CACHEDIR directory..."
   sudo mkdir -p $CACHEDIR
fi

if [ ! -f $FILEZIP ]; then
  
   if [ ! -f $CACHEDIR/$FILEZIP ]; then
     # downloading from WSO2 repository circumventing the required credentials
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

# finalization, directory permissions
echo "Finalizing configuration..."	
sudo chown -R vagrant: /opt/wso2/	
if [ ! -d /etc/.java/ ]; then
   sudo mkdir /etc/.java/
   sudo mkdir /etc/.java/.systemPrefs
   sudo chown -R vagrant: /etc/.java/.systemPrefs
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
