PROVISION="Basic Utilities (wget, unzip)"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

# set the time zone
sudo mv /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/CET /etc/localtime

# find IP addresses
sudo cat >/etc/profile.d/ipaddress.sh <<EOF
export IP4=$(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)
export IP6=$(/sbin/ip -o -6 addr list eth1 | awk '{print $4}' | cut -d/ -f1)
EOF

# download popular programs
if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
  sudo apt-get install -y wget
  sudo apt-get install -y zip
  sudo apt-get install -y unzip
  sudo apt-get install -y net-tools
  sudo apt-get install -y xmlstarlet
  
elif [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then
  sudo yum install -y wget
  sudo yum install -y zip
  sudo yum install -y unzip
  sudo yum install -y net-tools
  
  # xmlstarlet
  sudo wget -q http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo rpm -Uvh epel-release*rpm
  sudo yum install -y xmlstarlet
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
