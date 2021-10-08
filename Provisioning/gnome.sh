PROVISION="GNOME"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then
  sudo yum -q -y groupinstall "GNOME Desktop" "Graphical Administration Tools"
elif [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
  sudo apt-get install gnome ubuntu-desktop unity virtualbox-guest-x11 virtualbox-guest-dkms virtualbox-guest-additions-iso
fi

ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
sudo systemctl set-default graphical.target


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
