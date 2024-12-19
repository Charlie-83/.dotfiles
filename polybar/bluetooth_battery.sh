#!/usr/bin/bash
#address=$(bluetoothctl devices Paired | grep charliesweep | cut -d ' ' -f 2)
#echo "KB $(bluetoothctl info $addr | grep "Battery Percentage" | awk -F'[()]' '{print $2}')%"
python ~/.dotfiles/polybar/zmk_split_battery_level_linux.py
