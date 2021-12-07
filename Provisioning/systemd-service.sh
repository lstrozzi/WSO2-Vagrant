SCRIPT=$1
chmod a+x $SCRIPT

NAME=$(basename $SCRIPT | sed 's/\(.*\)\..*/\1/')
DIR=$(dirname $SCRIPT )
UNIT=$DIR/$NAME.service

PROVISION="System Service Provisioning"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."


echo "Creating system service " $NAME " with unit " $UNIT

cat << EOF > $UNIT
[Unit]
Description=$NAME
After=network.target

[Service]
Type=simple
StandardOutput=journal
StandardError=journal
WorkingDirectory=$DIR
ExecStart=$SCRIPT
User=vagrant
Restart=on-failure
RestartSec=10
Environment=JAVA_HOME=$JAVA_HOME

[Install]
WantedBy=multi-user.target
EOF


echo "Enabling system service " $UNIT
systemctl enable $UNIT

echo "Starting system service " $NAME
systemctl start $NAME


echo "**************************************************** Provisioning '"$PROVISION"' is finished."