PROVISION="MySql"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then

  echo "**** installing MariaDB..."
  sudo apt-get install -y mariadb-server mariadb-client

elif [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then

  sudo yum install -y wget
  wget https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
  sudo yum install -y mysql57-community-release-el7-8.noarch.rpm
  sudo yum -y update
  sudo yum -y install mysql-server
  sudo systemctl start mysqld
  sudo systemctl enable mysqld
  MYSQL_TEMP_PWD=`sudo cat /var/log/mysqld.log | grep 'A temporary password is generated' | awk -F'root@localhost: ' '{print $2}'`
  mysqladmin -u root -p`echo $MYSQL_TEMP_PWD` password 'Passw0rd!'
  cat << EOF > .my.cnf
[client]
user=root
password=Passw0rd!
EOF

  cat << EOF >> /etc/my.cnf
sql-mode = "NO_ENGINE_SUBSTITUTION"
EOF

fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
