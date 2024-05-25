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

## Setting Up Alerts, Triggers, and Actions in Zabbix

### Step 1: Access the Zabbix Web Interface

1. Open your web browser and go to `http://your_server_ip/zabbix`.
2. Log in with the default credentials (default username: `Admin`, password: `zabbix`).

### Step 2: Configure Media Types

1. Navigate to **Administration** > **Media types**.
2. Click on **Create media type**.
3. Enter the following details:
   - **Name**: `Email`
   - **Type**: `Script`
   - **Script name**: `zabbix_send_email.sh`
4. Click **Add** to save the media type.

### Step 3: Add a User and Set Up Email Notifications

1. Navigate to **Administration** > **Users**.
2. Click on **Create user**.
3. Fill in the user details:
   - **Alias**: `your_alias`
   - **Name**: `Your Name`
   - **Groups**: Add the user to a group, e.g., `Zabbix administrators`.
   - **Password**: Set a password.
4. In the **Media** tab:
   - Click on **Add**.
   - **Type**: `Email`
   - **Send to**: `your-email@gmail.com`
   - **When active**: `1-7,00:00-24:00` (always active)
   - **Use if severity**: Select the severity levels you want to be notified about.
5. Click **Add** to save the user and media.

### Step 4: Configure Email Settings in the UI

1. Navigate to **Administration** > **General**.
2. In the dropdown menu, select **Email**.
3. Configure the email settings:
   - **SMTP server**: `smtp.gmail.com`
   - **SMTP server port**: `587`
   - **SMTP helo**: `smtp.gmail.com`
   - **SMTP email**: `your-email@gmail.com`
   - **Connection security**: `STARTTLS`
   - **SMTP authentication**: `Username and password`
   - **Username**: `your-email@gmail.com`
   - **Password**: `your-app-password`
4. Click **Update** to save the email settings.

### Step 5: Create a Host and Link to a Template

1. Navigate to **Configuration** > **Hosts**.
2. Click on **Create host**.
3. Enter the host details:
   - **Host name**: `Your Host`
   - **Groups**: Add to an appropriate group, e.g., `Linux servers`.
   - **Interfaces**: Add an interface (e.g., `Agent`, `IP address: your_host_ip`).
4. In the **Templates** tab:
   - Click on **Add**.
   - Link to a template (e.g., `Template OS Linux`).
5. Click **Add** to save the host.

### Step 6: Create a Trigger

1. Navigate to **Configuration** > **Hosts**.
2. Click on the **Triggers** link for the host you created.
3. Click on **Create trigger**.
4. Enter the trigger details:
   - **Name**: `CPU Load High`
   - **Expression**: Click **Add** and use the expression constructor to create a trigger (e.g., `{Template OS Linux:system.cpu.load[percpu,avg1].last()}>5`).
   - **Severity**: Choose a severity level (e.g., `High`).
5. Click **Add** to save the trigger.

### Step 7: Create an Action

1. Navigate to **Configuration** > **Actions**.
2. Click on **Create action**.
3. Enter the action details:
   - **Name**: `Notify on High CPU Load`
   - **Conditions**: Click **Add** and set conditions (e.g., `Trigger value = PROBLEM` and `Trigger = CPU Load High`).
4. In the **Operations** tab:
   - Click on **Add** under **Action operations**.
   - **Operation type**: `Send message`
   - **Send to users**: Select the user you created.
   - **Send only to**: `Email`
5. Click **Add** to save the action.

### Step 8: Test the Configuration

1. Generate a test event that will trigger the alert (e.g., artificially increase CPU load on the host).
2. Check your email for the alert notification.

## Notes

- Make sure to set up an App Password in Gmail for use with `ssmtp` if 2-step verification is enabled.
- Adjust the database and email settings as needed.
