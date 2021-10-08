PROVISION="Configure GIT"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

	sudo yum -y install git
    
  
elif [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
    echo "ERROR: NOT SUPPORTED"
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
