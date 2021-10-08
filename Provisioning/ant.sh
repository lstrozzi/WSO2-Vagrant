PROVISION="Ant "
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

FILE=apache-ant-1.10.5
ZIP=$FILE-bin.tar.gz
if [ ! -d /opt/$FILE ]; then

  echo "**** Downloading Ant..."
  cd ~
  wget -q http://www.us.apache.org/dist/ant/binaries/$ZIP
  sudo tar xvfvz $ZIP -C /opt
  sudo ln -s /opt/$FILE /opt/ant
  
  echo "**** Configuring Ant..."
  sudo sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
  sudo ln -s /opt/ant/bin/ant /usr/bin/ant
  
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
