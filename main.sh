#!/bin/bash

# Start apache
source /etc/apache2/envvars
apachectl -f /etc/apache2/apache2.conf

# start proftpd
proftpd
wget https://raw.githubusercontent.com/crispy-peppers/splunk/main/splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb
dpkg -i splunkforwarder-8.2.2.1-ae6821b7c64b-linux-2.6-amd64.deb
/usr/bin/expect<<EOF
spawn /opt/splunkforwarder/bin/splunk start --accept-license
expect "This appears to be your first time running this version of Splunk.\r
\r
Splunk software must create an administrator account during startup. Otherwise, you cannot log in.\r
Create credentials for the administrator account.\r
Characters do not appear on the screen when you type in credentials.\r

Please enter an administrator username: "
send -- "admin\r"
expect "admin\r
Password must contain at least:\r
   * 8 total printable ASCII character(s).\r
Please enter a new password: "
send -- "lVB9N58ya7kGpEODxF\r"
expect -exact "\r
Please confirm new password: "
send -- "lVB9N58ya7kGpEODxF\r"
expect eof
EOF
echo $splunk_domain_name
/opt/splunkforwarder/bin/splunk add forward-server $splunk_domain_name:9997 -auth admin:lVB9N58ya7kGpEODxF
/opt/splunkforwarder/bin/splunk add monitor /var/log/apache2/ -auth admin:lVB9N58ya7kGpEODxF
tail -f /dev/null