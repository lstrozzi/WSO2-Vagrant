PROVISION="Remote Tail (rtail)"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

  if [ ! -f /usr/bin/rtail ]; then
    echo "**** Configuring NodeJS repository..."
    sudo curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
  
    echo "**** Installing NodeJS..."
    sudo yum install -y nodejs
  
    echo "**** Installing rtail..."
    sudo npm install -g rtail
  fi
  
  echo "**** Starting rtail server..."
  sudo rtail-server --web-host $IP4 --web-port 8888 &
  
elif [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
    echo "**** Installing NodeJS..."
    sudo apt-get install -y nodejs nodejs-legacy npm
  
    echo "**** Installing rtail..."
    sudo npm install -g rtail
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
