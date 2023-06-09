#!/bin/bash
# Create the virtual device
/sbin/iw dev wlan0 interface add uap0 type __ap
ifup uap0
sysctl net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 ! -d 192.168.2.0/24 -j MASQUERADE



sudo systemctl restart dnsmasq
sudo systemctl restart hostapd