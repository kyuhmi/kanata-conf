#!/usr/bin/env bash

# install kanata config to /etc
sudo cp kanata.kbd /etc/kanata.kbd

# Check if kanata service is already running
if systemctl is-active --quiet kanata.service; then
    echo "Kanata service is currently running."
    kanata_was_running=true
else
    kanata_was_running=false
fi

# Ask if user wants to install the service
read -rp "Do you want to install the systemd service for Kanata? (y/n): " install_service

if [[ "$install_service" =~ ^[Yy]$ ]]; then
    # Copy the service file
    sudo cp kanata.service /usr/lib/systemd/system/kanata.service

    # Reload systemd to recognize the new service
    sudo systemctl daemon-reload

    # Ask if user wants to enable and start the service
    read -rp "Do you want to enable and start the Kanata service now? (y/n): " start_service

    if [[ "$start_service" =~ ^[Yy]$ ]]; then
        sudo systemctl stop kanata.service
        sudo systemctl enable --now kanata.service
        echo "Kanata service has been enabled and started."
    else
        echo "Kanata service has been installed but not enabled."
        echo "You can enable it later with: sudo systemctl enable --now kanata.service"
    fi
elif [[ "$kanata_was_running" == true ]]; then
    # Ask if user wants to restart the service with new config
    read -rp "Kanata service is running. Do you want to restart it with the new configuration? (y/n): " restart_service

    if [[ "$restart_service" =~ ^[Yy]$ ]]; then
        echo "Restarting Kanata service with new configuration..."
        sudo systemctl restart kanata.service
        echo "Kanata service has been restarted."
    else
        echo "Kanata service is still running with the old configuration."
        echo "You can restart it later with: sudo systemctl restart kanata.service"
    fi
fi

echo "Installation complete."
