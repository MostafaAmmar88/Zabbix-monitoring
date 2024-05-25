# Zabbix-monitoring
Setting up Zabbix monitoring, including installation, dependencies, and configuration to send alerts to a Gmail account

# Zabbix Monitoring Setup

This repository contains scripts to install and configure Zabbix for monitoring and sending alerts to a Gmail account.

## Files

- `install_zabbix.sh`: Installs Zabbix server, frontend, agent, and MySQL.
- `configure_zabbix.sh`: Configures Zabbix to send email alerts via Gmail.

## Setup Instructions

1. **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/zabbix-monitoring.git
    cd zabbix-monitoring
    ```

2. **Run the installation script**
    ```bash
    chmod +x install_zabbix.sh
    sudo ./install_zabbix.sh
    ```

3. **Run the configuration script**
    ```bash
    chmod +x configure_zabbix.sh
    sudo ./configure_zabbix.sh
    ```

4. **Configure Zabbix Frontend**
    - Open your browser and navigate to `http://your_server_ip/zabbix`.
    - Follow the setup wizard to complete the configuration.

5. **Set up email alerts in Zabbix**
    - Go to `Administration` > `Media types` in Zabbix.
    - Create a new media type with the script `zabbix_send_email.sh`.
    - Add your email address in the `Users` section under `Media`.

## Notes

- Make sure to set up an App Password in Gmail for use with `ssmtp` if 2-step verification is enabled.
- Adjust the database and email settings as needed.

