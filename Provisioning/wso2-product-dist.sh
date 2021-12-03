if [[ $1 == https://product-dist.wso2.com/products/* ]]
then
  URL=$1
else
  echo "the argument is not a WSO2 product url"
  exit 1
fi

FILEZIP=$(echo $URL | sed 's/.*\/\(.*\)/\1/')
FILE=$(echo $FILEZIP | sed 's/\(.*\)\.zip/\1/')
FILEBASE=$(echo $FILEZIP | sed 's/\(.*\)-.*\.zip/\1/')
VERSION=$(echo $FILEZIP | sed 's/.*-\(.*\)\.zip/\1/')

PROVISION="WSO2 $FILEBASE $VERSION "
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

CACHEDIR=/vagrant_data/products

if [ ! -d "$CACHEDIR" ]; then
   echo "Creating $CACHEDIR directory..."
   sudo mkdir -p $CACHEDIR
fi

if [ ! -f $FILEZIP ]; then
  
   if [ ! -f $CACHEDIR/$FILEZIP ]; then
     # downloading from WSO2 repository circumventing the required credentials
     echo "Downloading " $URL "..."
     sudo wget -q --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" $URL
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
