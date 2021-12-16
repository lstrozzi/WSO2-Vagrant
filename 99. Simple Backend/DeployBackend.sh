PROVISION="DEPLOY BACKEND"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

echo "* Copying source files of the Java Backend"
cp -rf /vagrant/src ~/.

echo "* Compiling Java Backend"
cd ~/src/BackEnd

echo "**************************************************** Provisioning '"$PROVISION"' is finished."