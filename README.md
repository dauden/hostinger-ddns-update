# HOSTINGER DDNS UPDATE

A Bash script to dynamically update DNS A-records for domains you own on Hostinger, useful for home or private servers running behind dynamic IP addresses.

---

## Use Case

You should use this script if:

- You own domains managed via Hostinger.
- You want to self-host services (such as on a Synology NAS or private server).
- Your hosting device is behind a router with a dynamic public IP (assigned by your ISP) and needs its domain DNS A-records kept up-to-date automatically.

**Example:**  
You own `your_name.com` and want to expose your NAS/server to the internet (e.g., access at `https://your_name.com`).  
This script ensures the DNS record on Hostinger always points to your current public IP.

> **Note:**  
> For subdomains (e.g., `blog.your_name.com` or `storage.your_name.com`), you can manage redirection easily with CNAME records pointing to a DynDNS domain.  
> However, the root domain (A-records) must be updated directly, as A-records cannot be CNAMES. This script targets the dynamic update of A-records.

---

## Develop / Script

### Get API key from Hostinger

1. Log in to your Hostinger account and access hPanel.
2. Navigate to the **Overview** section in the main menu.
3. Choose **API New** from the sidebar menu.
4. Create a new API token by clicking the **New token** button.
5. Provide a name for your token (e.g., "DDNS Update").
6. Select the necessary permissions related to DNS management.
7. Click **Generate Token** to create your API key.
8. Copy the generated API key immediately, as it won't be shown again.
9. Update your `config.sh` file with this API key in the `API_KEY` variable.

> **Note:**  
> If the API section is not available in your hPanel, contact Hostinger support for assistance, as API access may vary depending on your hosting plan.

### Config Parameters

- The script expects a configuration file (`config.sh`) to be present in the same directory, defining necessary values such as:
    - `HOST`: Hostinger API base URL.
    - `API_VERSION`: API version for Hostinger DNS.
    - `LAST_IP_FILE`: File path to store the last known IP address.
    - `DOMAIN`: The domain name to update.
    - `API_KEY`: Your personal Hostinger API key.
    - `ZONE`: The DNS record's zone (e.g., "@", "www", etc.).
- It uses `curl` for HTTP requests and `jq` for JSON parsing. Both utilities must be installed.

---

## Deploy the Script

### Synology NAS

1. Copy the `ddns.hostinger.sh` script and `config.sh` to your Synology NAS.
2. Make sure both `curl` and `jq` are installed.
3. Set up a scheduled task in DSM to run the script periodically (e.g., every 10 minutes).

**Example:**
1. Create a directory for the script in the scripts shared folder: `/volume1/scripts/hostinger_ddns/`
2. Copy the `ddns.hostinger.sh` script and `config.sh` to this directory.
3. Make the script executable:
     ```bash
     chmod +x /volume1/scripts/hostinger_ddns/ddns.hostinger.sh
     ```
4. Install required dependencies:
  - For `curl`: It should be pre-installed on Synology.
  - For `jq`: Install via Package Center or manually:
    ```bash
    # Install Entware if not already installed
    sudo mkdir -p /opt
    sudo mount -o bind /volume1/@optware /opt
    wget -O - http://bin.entware.net/x64-k3.2/installer/generic.sh | /bin/sh
    # Install jq
    opkg update
    opkg install jq
    ```
5. Set up a scheduled task in DSM:
  - Open Control Panel → Task Scheduler
  - Click "Create" → "Scheduled Task" → "User-defined script"
  - Set a task name (e.g., "Hostinger DDNS Update")
  - Set the user to "root"
  - Set the task to run as frequently as needed (recommended: every 10-15 minutes)
  - In the "Run command" field, enter:
    ```bash
    /volume1/scripts/hostinger_ddns/ddns.hostinger.sh
    ```
  - Click "OK" to save the task
### Local Server

1. Place the `ddns.hostinger.sh` script and `config.sh` in your preferred directory.
2. Ensure `curl` and `jq` are available on your system.
3. Set up a cron job for periodic execution (e.g., via `crontab -e`).

---

This utility helps automate public IP tracking and DNS updating, keeping your self-hosted services reliably reachable over the internet.