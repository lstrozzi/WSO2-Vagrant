BOX="centos-t2b"
cd ~/VirtualBox\ VMs
vagrant package --base=$BOX --output=$BOX.box

mkdir -p ~/vagrant
cp $BOX.box ~/vagrant
cd ~/vagrant

vagrant box add --name=$BOX $BOX.box
