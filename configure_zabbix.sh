#!/bin/bash

# Update Zabbix server configuration for Gmail alerts
sudo bash -c 'cat << EOF >> /etc/zabbix/zabbix_server.conf
# Email settings for alerts
AlertScriptsPath=/usr/lib/zabbix/alertscripts
EOF'

# Create directory for alert scripts
sudo mkdir -p /usr/lib/zabbix/alertscripts

# Create email script
sudo bash -c 'cat << EOF > /usr/lib/zabbix/alertscripts/zabbix_send_email.sh
#!/bin/bash
to=$1
subject=$2
body=$3
echo "\$body" | mail -s "\$subject" "\$to"
EOF'

# Make the script executable
sudo chmod +x /usr/lib/zabbix/alertscripts/zabbix_send_email.sh

# Install mailutils
sudo apt-get install -y mailutils

# Configure Gmail as SMTP relay (requires setting up an App Password in Gmail)
sudo bash -c 'cat << EOF > /etc/ssmtp/ssmtp.conf
root=your-email@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=your-email@gmail.com
AuthPass=your-app-password
UseSTARTTLS=YES
EOF'

echo "Zabbix configuration for email alerts completed!"
