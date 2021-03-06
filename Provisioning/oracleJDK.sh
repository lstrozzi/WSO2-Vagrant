PROVISION="Oracle JDK 1.8_131"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

CACHEDIR=/vagrant_data/products

if [ ! -d "$CACHEDIR" ]; then
   echo "Creating $CACHEDIR directory..."
   sudo mkdir -p $CACHEDIR
fi

FILE=jdk-8u131-linux-x64.tar.gz

# dowloading Oracle JDK
if [ ! -d /usr/java ]; then
   if [ ! -d /opt/dl ]; then
      mkdir /opt/dl
   fi
   cd /opt/dl
   
   if [ ! -d $CACHEDIR/$FILE ]; then
     echo "Downloading jdk-8u131-linux-x64.tar.gz..."
     wget -q -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/$FILE
	 cp $FILE $CACHEDIR/
   else
     echo "Using cached copy of jdk-8u131-linux-x64.tar.gz"
     cp $CACHEDIR/$FILE .
   fi

   if [ -f $FILE ]; then
     echo "Unzipping jdk-8u131-linux-x64.tar.gz..."
     sudo mkdir /usr/java
     sudo tar -xzf jdk-8u131-linux-x64.tar.gz -C /usr/java
     echo 'export JAVA_HOME=/usr/java/jdk1.8.0_131' | sudo tee -a /etc/profile.d/envvars.sh
     echo 'export PATH=$PATH:/usr/java/jdk1.8.0_131/bin' | sudo tee -a /etc/profile.d/envvars.sh
   else
     echo "**** ERROR: Cannot download" $FILE
   fi
else
   echo $PROVISION "is already provisioned"
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
