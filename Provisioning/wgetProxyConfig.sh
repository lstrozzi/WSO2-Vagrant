PROVISION="wget Proxy Config"
echo "**************************************************** Provisioning '"$PROVISION"' is starting..."

# set the time zone
sudo cat >/etc/wgetrc <<EOF
use_proxy=yes
http_proxy=http://Luca-Yenlo:3128/
https_proxy=http://Luca-Yenlo:3128/
ftp_proxy=http://Luca-Yenlo:3128/
EOF

echo "The Http / Https / Ftp Proxy is: http://Luca-Yenlo:3128/"

echo "**************************************************** Provisioning '"$PROVISION"' is finished."
