apictl get envs

# apictl add env production

apictl add-env -e dev \
--registration https://localhost:9443 \
--publisher https://localhost:9443 \
--devportal https://localhost:9443 \
--admin https://localhost:9443 \
--token https://localhost:8243/token

apictl change-status api -a Publish -n PizzsShack -v 1.0.0 -e dev
