# Tenten Dynamic DNS Updater

A Python-based dynamic DNS updater for domain.tenten.vn using Playwright browser automation. Since tenten.vn doesn't provide a DUC (Dynamic Update Client) service, this tool automates the web interface to update DNS A records when your IP address changes.

## Features

- **Automated Login**: Handles login to domain.tenten.vn with your credentials
- **DNS Record Updates**: Automatically updates A records with your current public IP
- **Multiple IP Detection Services**: Uses multiple services to reliably detect your public IP
- **Robust Selectors**: Handles various web interface layouts with multiple selector strategies
- **Comprehensive Logging**: Detailed logs for troubleshooting and monitoring
- **Configurable**: JSON-based configuration for easy customization
- **Headless Operation**: Runs invisibly in the background

## Requirements

- Python 3.7+
- Chrome/Chromium browser (installed automatically by Playwright)
- Active domain.tenten.vn account

## Installation

1. **Clone or download the project files**

2. **Run the setup script**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

   Or manually:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   playwright install chromium
   ```

3. **Configure your credentials**:
    - Copy the sample config: `cp config.json.sample config.json`
    - Edit `config.json` with your actual credentials and domain settings

## Configuration

Edit the `config.json` file with your settings:

```json
{
   "credentials": {
      "username": "your_tenten_username",
      "password": "your_tenten_password"
   },
   "domain_settings": {
      "configuration_by_ip_btn_text": "Cấu hình theo IP"
   },
   "browser_settings": {
      "headless": true,
      "user_data_dir": "chrome-data", // Directory for persistent browser data
      "timeout": 30000,
      "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
   },
   "logging": {
      "level": "DEBUG", // DEBUG, INFO, WARNING, ERROR
      "file": "ddns_updater.log"
   }
}
```

## Usage

### Basic Usage
```bash
# Auto-detect current IP and update DNS
python ddns_updater.py

# Update with specific IP address
python ddns_updater.py --ip 1.2.3.4

# Enable verbose logging
python ddns_updater.py --verbose

# Use custom config file
python ddns_updater.py --config my_config.json
```

### Automated Updates
Set up a cron job for automatic updates:

```bash
# Edit crontab
crontab -e

# Add entry to check every 15 minutes
*/15 * * * * /path/to/your/project/venv/bin/python /path/to/your/project/ddns_updater.py
```

### Systemd Service (Linux)
Create a systemd service for continuous monitoring:

```ini
[Unit]
Description=Tenten Dynamic DNS Updater
After=network.target

[Service]
Type=simple
User=your_username
WorkingDirectory=/path/to/your/project
ExecStart=/path/to/your/project/venv/bin/python ddns_updater.py
Restart=always
RestartSec=300

[Install]
WantedBy=multi-user.target
```

## How It Works

1. **IP Detection**: Gets your current public IP from multiple services (ipify.org, ifconfig.me, icanhazip.com)
2. **Browser Automation**: Uses Playwright to navigate to domain.tenten.vn
3. **Login Handling**: Automatically detects login redirects and enters credentials
4. **DNS Management**: Locates your domain and A records in the management interface
5. **Record Update**: Updates the IP address and saves the changes
6. **Verification**: Checks for success messages and logs the results

## Troubleshooting

### Common Issues

**Login Failures**:
- Verify your username and password in `config.json`
- Check if your account is locked or requires 2FA
- Set `"headless": false` to see the browser and debug

**DNS Update Failures**:
- Ensure your domain is properly configured in tenten.vn
- Check the subdomain setting (use "@" for root domain)
- Review logs for specific error messages

**Browser Issues**:
- Run `playwright install chromium` to reinstall browser
- Update Playwright: `pip install --upgrade playwright`

### Debug Mode
Run with debug logging to see detailed execution:
```bash
python ddns_updater.py --verbose
```

### Log Files
Check the log file (default: `ddns_updater.log`) for detailed information about each run.

## Security Notes

- Store your `config.json` file securely with appropriate file permissions
- Consider using environment variables for credentials in production
- Regularly rotate your tenten.vn account password
- Monitor logs for any suspicious activity

## Limitations

- Depends on tenten.vn's web interface (may break if they change their UI)
- Requires a full browser instance (more resource-intensive than API calls)
- No official support from tenten.vn (use at your own risk)

## Contributing

Feel free to submit issues and enhancement requests. The tool uses multiple selector strategies to handle interface changes, but may need updates if tenten.vn significantly changes their web interface.

## License

This project is for educational and personal use. Ensure you comply with tenten.vn's terms of service when using this tool.