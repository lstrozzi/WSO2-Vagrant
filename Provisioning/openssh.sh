PROVISION="Configure SSH Server"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

	SEDFILE=/etc/ssh/sshd_config
	sudo sed -i 's:#PubkeyAuthentication yes:PubkeyAuthentication yes:' $SEDFILE
	sudo sed -i 's:PasswordAuthentication no:PasswordAuthentication yes:' $SEDFILE
	sudo systemctl restart sshd.service
    
  
elif [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
    echo "ERROR: NOT SUPPORTED"
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
