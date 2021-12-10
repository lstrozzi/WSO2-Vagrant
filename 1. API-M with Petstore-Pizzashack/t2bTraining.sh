PROVISION="t2b Training for API Manager (no Micro-gateway)"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

echo "*** Here are the current available environments:"
apictl get envs

echo "*** Executing: apictl add env dev"
apictl add env dev \
--registration https://localhost:9443 \
--publisher https://localhost:9443 \
--devportal https://localhost:9443 \
--admin https://localhost:9443 \
--token https://localhost:8243/token

echo "*** Changing status of dev env"
apictl change-status api -a Publish -n PizzsShack -v 1.0.0 -e dev

echo "*** Changing 'localhost' to "$IP4" in the configuration file deployment.toml"
SEDFILE=/opt/wso2/wso2am/repository/conf/deployment.toml
sed -i 's:localhost:'$IP4':' $SEDFILE
sed -i 's:#\[apim.devportal\]:\[apim.devportal\]:' $SEDFILE
sed -i 's:#url = "https\://'$IP4'\:${mgt.transport.https.port}/devportal":url = "https\://'$IP4'\:${mgt.transport.https.port}/devportal":' $SEDFILE
sed -i 's:#\[apim.key_manager\]:\[apim.key_manager\]:' $SEDFILE
sed -i 's:#url = "https\://'$IP4'\:${mgt.transport.https.port}/services":url = "https\://'$IP4'\:${mgt.transport.https.port}/services":' $SEDFILE

echo "**************************************************** Provisioning '"$PROVISION"' is finished."