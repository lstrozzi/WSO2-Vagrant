PROVISION="Ansible"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# Install Ansible
if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then

  echo "**** Running on Ubuntu..."
  sudo apt-get install updates

  # Optional: install packages needed to download and compile ansible
  sudo apt-get install make git make python-setuptools gcc python-dev libffi-dev libssl-dev python-packaging

  # Install Ansible
  sudo apt-get install -y ansible

elif [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

  echo "**** Running on CentOS..."
  sudo yum update
  sudo yum install ansible

fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
