#!/usr/bin/env bash
PROVISION="Configuring WSO2 API-M Microgateway"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

SHELLFILE=/etc/profile.d/wso2am-micro-gw.sh
echo "* Creating shell file "$SHELLFILE
sudo cat << EOF > $SHELLFILE
MGW_HOME=/opt/wso2/wso2am-micro-gw-linux
export MGW_HOME
MGW_TK_HOME=/opt/wso2/wso2am-micro-gw-toolkit-linux
export MGW_TK_HOME
PATH=\$PATH:\$MGW_HOME/bin:\$MGW_TK_HOME/bin
export PATH
EOF


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
