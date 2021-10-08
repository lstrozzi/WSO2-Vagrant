PROVISION="Google Chrome"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then

  echo "**** Configuring apt repositories for Google Chrome..."
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

  echo "**** Installing Google Chrome..."
  sudo apt-get update 
  sudo apt-get install -y google-chrome-stable

elif [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then
  echo "**** ERROR: I don't know how to install Google Chrome on CentOS"
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
