#!/bin/sh
NAME=Hospital-Service
DIR="/opt/wso2/$NAME"
echo "Install $NAME in $DIR"
mkdir $DIR
cd $DIR
URL=https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar?raw=true
wget -q --user-agent="testuser" -O $NAME.jar $URL
SCRIPT="$NAME.sh"

cat << EOF > $SCRIPT
#!/bin/sh
cd $DIR
PATH=\$JAVA_HOME/bin/
java -jar $NAME.jar
EOF

chmod a+x $SCRIPT
chown vagrant:vagrant $SCRIPT
