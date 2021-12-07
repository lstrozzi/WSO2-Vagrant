PROVISION="Remote Tail (rtail)"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

  if [ ! -f /usr/bin/rtail ]; then
    echo "**** Configuring NodeJS repository..."
    sudo curl -sL https://rpm.nodesource.com/setup_14.x | bash -
  
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

if [ ! -d /opt/rtail ]; then
	mkdir /opt/rtail
fi

cat >/opt/rtail/start-rtail.sh <<EOF
#!/bin/sh
rtail-server --wh $IP4 --wp 8889 --uh $IP4 --up 8889
EOF
chmod a+x /opt/rtail/start-rtail.sh

cat >/opt/rtail/rtail-wso2am.sh <<EOF
#!/bin/sh
nohup tail -f /opt/wso2/wso2am/repository/logs/wso2carbon.log | rtail --mute --host $IP4 --port 8889 --id wso2AM
EOF
chmod a+x /opt/rtail/rtail-wso2am.sh



echo "**************************************************** Provisioning '"$PROVISION"' is finished."
