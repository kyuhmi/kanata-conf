#!/usr/bin/env bash

# install kanata config to /etc
sudo cp kanata.kbd /etc/kanata.kbd

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
        sudo systemctl enable --now kanata.service
        echo "Kanata service has been enabled and started."
    else
        echo "Kanata service has been installed but not enabled."
        echo "You can enable it later with: sudo systemctl enable --now kanata.service"
    fi
fi

echo "Installation complete."
