SCRIPT=$1
chmod a+x $SCRIPT

NAME=$(basename $SCRIPT | sed 's/\(.*\)\..*/\1/')
DIR=$(dirname $SCRIPT )
UNIT=$DIR/$NAME.service

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
systemctl enable $UNIT
