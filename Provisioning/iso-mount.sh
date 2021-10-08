PROVISION="Mounting CentOS ISO Drive"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

	mkdir /media/cdrom
    mount -r -t iso9660 /dev/cdrom /media/cdrom
    yum --disablerepo=* --enablerepo=c7-media list
	
elif [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
    echo "ERROR: NOT SUPPORTED"
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
