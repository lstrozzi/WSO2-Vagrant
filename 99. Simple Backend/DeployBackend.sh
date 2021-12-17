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
echo "* ...ok"


echo "**************************************************** Provisioning '"$PROVISION"' is finished."