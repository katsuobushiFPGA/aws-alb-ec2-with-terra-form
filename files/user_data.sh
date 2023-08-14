#!/bin/bash
sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd