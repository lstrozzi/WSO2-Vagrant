PROVISION="Home Configuration"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


# if [ "grep /etc/hosts  = "Ubuntu" ]; then

sudo cat >>/etc/hosts <<EOF
10.0.1.10 gandalf
10.0.1.25 luca-t2b
192.168.1.11 wso2ei
192.168.1.12 wso2am
EOF

# fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
