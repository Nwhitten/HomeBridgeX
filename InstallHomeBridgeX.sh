#!/bin/bash

	systemctl stop pi-monitor2.service

echo ""

echo "Downloading pi-monitor files..."

wget https://raw.githubusercontent.com/nwhitten/pi_monitor/master/pi-monitor2.py
wget https://raw.githubusercontent.com/nwhitten/pi_monitor/master/pi-monitor2.service

echo ""

echo "Removing old pi-monitor files..."
rm /usr/local/bin/pi-monitor2.py
rm /etc/systemd/system/pi-monitor2.service

echo ""

echo "Moving pi-monitor files..."
mv pi-monitor2.py /usr/local/bin/
mv pi-monitor2.service /etc/systemd/system/

echo ""

echo "Starting pi-monitor service..."
systemctl daemon-reload
systemctl enable pi-monitor2.service 
systemctl start pi-monitor2.service




echo "Adding the Homebridge Repository GPG key..."
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
echo ""

echo "Adding the Homebridge Repository to the system sources..."
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
echo ""

echo "Updating repositories..."
sudo apt-get update
echo ""

echo "Installing Homebridge..."
sudo apt-get install homebridge
echo ""