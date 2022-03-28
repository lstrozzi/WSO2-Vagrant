OFFSET=0
PROVISION="BALLERINA"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

echo "* downloading and installing Ballerina"
sudo apt install /vagrant_data/products/ballerina-2201.0.1-swan-lake-linux-x64.deb
sudo ln -s /usr/lib/ballerina/bin/bal /usr/bin

echo "* installing demoModule"
cd ~
mkdir src
cd src
bal new demo-project
bal add demoModule
bal test -a
bal run demoModule
cd ~

echo "* "
echo "* To install the Visual Studio Code extension, open this: https://marketplace.visualstudio.com/items?itemName=WSO2.Ballerina"


echo "**************************************************** Provisioning '"$PROVISION"' is finished."
