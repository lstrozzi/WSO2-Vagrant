PROVISION="WSO2 PizzaShack"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# create the directory for wso2	
FILE=/opt/wso2
if [ ! -d $FILE ]; then
    echo "Creating /opt/wso2 directory..."
    sudo mkdir /opt/wso2
fi

# downloading PizzaShack example for WSO2
PIZZA=PizzaShack.zip
if [ ! -f $PIZZA ]; then
   echo "Downloading " $PIZZA "..."
   sudo wget -q https://raw.githubusercontent.com/wso2/product-app-manager/master/modules/samples/PizzaShack/PizzaShack.zip
   echo "Unzipping " $PIZZA " into /opt/wso2..."
   sudo unzip -q -o $PIZZA -d /opt/wso2

   echo "**** Compiling pizza-shack-api..."
   SEDFILE=pom.xml
   cd /opt/wso2/pizza-shack-api
   sed -i 's:<parent>:<!--parent>:' $SEDFILE
   sed -i 's:</parent>:</parent-->:' $SEDFILE
   sed -i 's:<modelVersion>:<version>1.0.0</version><modelVersion>:' $SEDFILE
   mvn -q clean install
   echo "**** Deploying pizza-shack-api..."
   cp target/*.war /opt/wso2/wso2as/repository/deployment/server/webapps/

   echo "**** Compiling pizza-shack-web..."
   cd /opt/wso2/pizza-shack-web
   sed -i 's:<parent>:<!--parent>:' $SEDFILE
   sed -i 's:</parent>:</parent-->:' $SEDFILE
   sed -i 's:<modelVersion>:<version>1.0.0</version><modelVersion>:' $SEDFILE
   mvn -q clean install
   echo "**** Deploying pizza-shack-web..."
   cp target/*.war /opt/wso2/wso2as/repository/deployment/server/webapps/

else
   echo $PIZZA " is already downloaded."
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
