PROVISION="t2b Training for API Manager (no Micro-gateway)"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

echo "Here are the current available environments:"
apictl get envs

echo "Executing: apictl add env dev"
apictl add env dev \
--registration https://localhost:9443 \
--publisher https://localhost:9443 \
--devportal https://localhost:9443 \
--admin https://localhost:9443 \
--token https://localhost:8243/token

echo "Changing status of dev env"
apictl change-status api -a Publish -n PizzsShack -v 1.0.0 -e dev



echo "**************************************************** Provisioning '"$PROVISION"' is finished."