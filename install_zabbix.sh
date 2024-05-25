#!/bin/bash

# Update package list
sudo apt-get update

# Install Zabbix repository
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu$(lsb_release -rs)_all.deb
sudo dpkg -i zabbix-release_6.0-1+ubuntu$(lsb_release -rs)_all.deb
sudo apt-get update

# Install Zabbix server, frontend, agent
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

# Install MySQL server
sudo apt-get install -y mysql-server

# Create initial database
sudo mysql -e "CREATE DATABASE zabbix CHARACTER SET UTF8 COLLATE UTF8_BIN;"
sudo mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Import initial schema and data
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | sudo mysql -u zabbix -p zabbix

# Configure database for Zabbix server
sudo sed -i 's/# DBPassword=/DBPassword=password/' /etc/zabbix/zabbix_server.conf

# Start Zabbix server and agent processes
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

echo "Zabbix installation completed!"
