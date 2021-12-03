#!/usr/bin/env bash
URL="https://product-dist.wso2.com/downloads/api-manager/cli/4.0.0/apictl-4.0.0-linux-x64.tar.gz"
wget -q --user-agent="testuser" $URL
tar -xzf apictl-4.0.0-linux-x64.tar.gz --directory=/opt/wso2
cat << EOF > /etc/profile.d/wso2am-apictl.sh
PATH=\$PATH:/opt/wso2/apictl
export PATH
EOF
