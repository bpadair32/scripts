#!/usr/bin/env bash

directory=$HOME/Documents/Notes/

newnote() {
	name="$(echo "" | rofi -dmenu -p "Enter a name: " <&-)" || exit 0
	: "${name:=$(date +%F_%T | tr ':' '-')}"
	setsid -f kitty -e nvim $directory$name".md" >/dev/null 2>&1
}

selected_note() {
	choice=$(echo -e "New\n$(command fd . $directory)" | rofi -dmenu - p "Choose note or create a new one")
	case $choice in
	New) newnote ;;
	*.md)
		setsid -f kitty -e nvim "$choice" >/dev/null 2>&1
		;;
	*) exit ;;
	esac
}

selected_note
