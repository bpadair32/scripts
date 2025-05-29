#!/usr/bin/env bash

DEVICE=$(bluetoothctl devices | rofi -dmenu | awk '{ print $2 }')

if [[ $(bluetoothctl info $DEVICE | grep Connected | awk '{ print $2 }') = "no" ]]; then
	bluetoothctl connect $DEVICE
	if [[ $? = 0 ]]; then
		notify-send "Connected" "Connection succeeded"
	else
		notify-send "Error" "Connection failed"
	fi
else
	bluetoothctl disconnect $DEVICE
	if [[ $? = 0 ]]; then
		notify-send "Disconnected" "Disconnected successfully"
	else
		notify-send "Error" "Failed to disconnect"
	fi
fi
