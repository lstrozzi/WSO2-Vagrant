#!/usr/bin/env bash
# https://mg.docs.wso2.com/en/latest/getting-started/quick-start-guide/quick-start-guide-binary/
micro-gw init petstore -a https://raw.githubusercontent.com/wso2/product-microgateway/master/samples/petstore_v3.yaml
micro-gw build petstore
gateway petstore/target/petstore.jar > gateway.out &

GATEWAY_PID=$!
export GATEWAY_PID

while [ -z "$(cat gateway.out | grep 'HTTPS listener is active on port 9095')" ]
do
  echo "wait for gateway ..."
  sleep 1
done

TOKEN=$(curl -X get "https://localhost:9095/apikey" -H "Authorization:Basic YWRtaW46YWRtaW4=" -k)
export TOKEN

curl -X GET "https://localhost:9095/api/v3/pet/findByStatus?status=available" -H "accept: application/json" -H "api_key:$TOKEN" -k
