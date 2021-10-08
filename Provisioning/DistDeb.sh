VERSION="2.6.0"
PROVISION="Distributed API-M (5 modules)"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


echo "**** Copying the DistDeb files..."
if [ ! -d /opt/wso2/Desktop/DIST_DEB_APIM260 ]; then
  mkdir /opt/wso2/Desktop
  cd /opt/wso2/Desktop
  ln -s /opt/wso2/wso2am-$VERSION wso2am-$VERSION
  ln -s /home/vagrant/wso2am-$VERSION.zip wso2am-$VERSION.zip
fi

if [ ! -d /opt/wso2/Desktop/DIST_DEB_APIM260 ]; then
  cd /opt/wso2/Desktop
  unzip /vagrant_data/DistDeb/DIST_DEB_APIM260.zip
  cd /opt/wso2/Desktop/DIST_DEB_APIM260
  chmod u+x *.sh
fi

echo "**** Executing DistDeb installation..."
cd /opt/wso2/Desktop/DIST_DEB_APIM260
./createDISTDEB.sh
  

echo "**************************************************** Provisioning '"$PROVISION"' is finished."
