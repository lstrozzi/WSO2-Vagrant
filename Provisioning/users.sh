# configure username
USER=luca

# create user with password
pass=$(perl -e 'print crypt("2001", "password")' $password)
sudo useradd -m -p $pass $USER

sudo chown -R $USER:$USER /opt/wso2/
sudo chown -R $USER:$USER /etc/.java/.systemPrefs
sudo chmod -R 755 /etc/.java
sudo touch /etc/.java/.systemPrefs/.system.lock
sudo touch /etc/.java/.systemPrefs/.systemRootModFile
sudo chmod 544 /etc/.java/.systemPrefs/.system.lock /etc/.java/.systemPrefs/.systemRootModFile
sudo chown -R luca:luca /etc/.java/.systemPrefs
sudo chmod -R 775 ~/.java
sudo chown -R luca:root ~/.java

if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
  sudo usermod -aG sudo $USER
elif [ "$(. /etc/os-release; echo $NAME)" = "CentOS Linux" ]; then
  sudo usermod -aG wheel $USER
fi

echo "configuring SSH access"
sudo mkdir /home/luca/.ssh
sudo cat >/home/luca/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH5V3Ia86ovcNdW5XrKs0L6HgwXsdr+WFDnHz/Ihj00qI0mvjtFk91KpmmsBsSxykrNp5dEK79cw+tMvrQkE0uxWIqEaYm7AKKPFHEnIrQE6cdFUMXpft5BwmHV15Te08Ew6E4hFEF/A/vUaOvCHV4r3vLSx1uqqsLupKMhWbHh3g5u6PyCLGc8WD7Sw7OjlA/F4KeGbmzw5MRj0XSwJcXDkm3tbxMv1ZgYnsflydqLr9LE9YrkJU7hRKNXHoluvJYK1h422JlqbtAy8tyZEpyeRlC2Zb8GNq9NYnW2WoytlYf8oo+TxDKalaLpfJUNPBvaEgFwhzAw1+PhEpvnAi/ luca_@Luca-Yenlo
EOF
sudo chmod 600 /home/luca/.ssh/authorized_keys
sudo chown -R luca:luca /home/luca/.ssh


cat >/home/luca/start-rtail.sh <<EOF
#!/bin/sh
sudo rtail-server --wh $IP4 --wp 8888 &
EOF
chmod a+x /home/luca/start-rtail.sh

cat >/home/luca/rtail-wso2as.sh <<EOF
#!/bin/sh
cd /opt/wso2/wso2as/bin/
nohup tailf /opt/wso2/wso2as/repository/logs/wso2carbon.log | rtail --mute --id wso2AS &
EOF
cat >/home/luca/rtail-wso2am.sh <<EOF
#!/bin/sh
cd /opt/wso2/wso2am/bin/
nohup tailf /opt/wso2/wso2am/repository/logs/wso2carbon.log | rtail --mute --id wso2AM &
EOF
cat >/home/luca/rtail-wso2am-analytics.sh <<EOF
#!/bin/sh
cd /opt/wso2/wso2am-analytics/bin/
nohup tailf /opt/wso2/wso2am-analytics/repository/logs/wso2carbon.log | rtail --mute --id wso2AM-Analytics &
EOF
chmod a+x /home/luca/rtail-wso2as.sh /home/luca/rtail-wso2am.sh /home/luca/rtail-wso2am-analytics.sh
