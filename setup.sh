#!/bin/bash

# Tenten Dynamic DNS Setup Script

echo "Setting up Tenten Dynamic DNS Updater..."

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install Python dependencies
echo "Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Install Playwright browsers
echo "Installing Playwright browsers..."
playwright install chromium

# Make the script executable
chmod +x ddns_updater.py

echo "Setup completed!"
echo ""
echo "Next steps:"
echo "1. Edit config.json with your tenten.vn credentials"
echo "2. Run: python ddns_updater.py"
echo ""
echo "Usage examples:"
echo "  python ddns_updater.py                    # Auto-detect IP and update"
echo "  python ddns_updater.py --ip 1.2.3.4      # Update with specific IP"
echo "  python ddns_updater.py --verbose          # Enable debug logging"
echo ""