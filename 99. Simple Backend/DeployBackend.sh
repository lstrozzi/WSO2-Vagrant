PROVISION="DEPLOY BACKEND"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

if [ ! -d src ]; then
  echo "* Copying source files of the Java Backend..."
  cp -rf /vagrant/src .
  chmod -R a+rwx src
  echo "* ...ok"
fi

echo "* Compiling Java Backend..."
cd src
javac JavaHTTPServer.java
cd ..
echo "* ...ok"

if [ ! -f Hospital-Service-JDK11-2.0.0.jar ]; then
  echo "* Downloading WSO2 Example Hospital-Service-JDK11-2.0.0.jar..."
  curl https://raw.githubusercontent.com/wso2-docs/WSO2_EI/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar >Hospital-Service-JDK11-2.0.0.jar
  echo "* ...ok"
fi


echo "**************************************************** Provisioning '"$PROVISION"' is finished."