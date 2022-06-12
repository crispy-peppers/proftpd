#!/bin/bash

# Start apache
source /etc/apache2/envvars
apachectl -f /etc/apache2/apache2.conf

# start proftpd
proftpd
wget https://download.splunk.com/products/universalforwarder/releases/8.2.6/linux/splunkforwarder-8.2.6-a6fe1ee8894b-linux-2.6-amd64.deb
dpkg -i splunkforwarder-8.2.6-a6fe1ee8894b-linux-2.6-amd64.deb
cat <<EOF >/opt/splunkforwarder/etc/system/local/user-seed.conf
[user_info]
USERNAME=admin
PASSWORD=lVB9N58ya7kGpEODxF
EOF
echo $splunk_domain_name
/opt/splunkforwarder/bin/splunk start --no-prompt --accept-license --answer-yes
/opt/splunkforwarder/bin/splunk add forward-server $splunk_domain_name:9997 -auth admin:lVB9N58ya7kGpEODxF
/opt/splunkforwarder/bin/splunk add monitor /var/log/apache2/ -auth admin:lVB9N58ya7kGpEODxF
tail -f /dev/null