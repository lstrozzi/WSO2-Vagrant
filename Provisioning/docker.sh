PROVISION="Docker"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# Install Docker
if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then

  echo "**** Running on Ubuntu..."
  sudo apt-get install updates

  # Install Ansible
  sudo apt-get install -y docker docker-compose

elif [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

  echo "**** Running on CentOS..."
  sudo yum update
  sudo yum install -y docker docker-compose

fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
