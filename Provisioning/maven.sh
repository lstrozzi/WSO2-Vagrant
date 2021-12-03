VERSION=3.6.3
FILE=apache-maven-$VERSION

PROVISION="Maven $VERSION"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

if [ ! -d /opt/$FILE ]; then

  echo "**** Downloading Maven..."
  cd ~
  wget -q https://dlcdn.apache.org/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz
  tar -zxvf apache-maven-$VERSION-bin.tar.gz
  rm -f apache-maven-$VERSION-bin.tar.gz

  # Configure Maven
  echo "**** Configuring Maven..."
  sudo mv ~/$FILE /opt
  sudo chown -R root:root /opt/$FILE
  sudo ln -s /opt/$FILE /opt/apache-maven
  echo 'export PATH=$PATH:/opt/apache-maven/bin' | sudo tee -a /etc/profile.d/envvars.sh
  source /etc/environment
  
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
