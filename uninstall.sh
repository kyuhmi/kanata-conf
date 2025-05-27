#!/usr/bin/env bash

# Remove the keyboard configuration
sudo rm /etc/kanata.kbd

# Check if the service file exists
if [ -f /usr/lib/systemd/system/kanata.service ]; then
    # Ask if user wants to remove the service
    read -rp "Do you want to remove the systemd service for Kanata? (y/n): " remove_service

    if [[ "$remove_service" =~ ^[Yy]$ ]]; then
        # Stop and disable the service if it's running
        sudo systemctl stop kanata.service 2>/dev/null
        sudo systemctl disable kanata.service 2>/dev/null

        # Remove the service file
        sudo rm /usr/lib/systemd/system/kanata.service
        # Reload systemd
        sudo systemctl daemon-reload

        echo "Kanata service has been removed."
    fi
fi

echo "Uninstallation complete."
