PROVISION="TEST BACKEND"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

echo "* Testing backend..."
curl http://localhost:8080/hello
echo "* ...ok"

echo "**************************************************** Provisioning '"$PROVISION"' is finished."