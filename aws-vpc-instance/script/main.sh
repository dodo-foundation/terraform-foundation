#!/usr/bin/env bash
sudo apt update
sudo apt install apache2 jenkins -y
sudo systemctl start apache2
sudo systemctl start jenkins
sudo systemctl enable apache2