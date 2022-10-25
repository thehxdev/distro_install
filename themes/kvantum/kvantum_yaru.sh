#!/usr/bin/env bash

#print OK
function print_ok() {
	echo -e "${OK} $1 ${Color_Off}"
}

#print ERROR
function print_error() {
	echo -e "${ERROR} $1 ${Color_Off}"
}

function judge() {
	if [[ 0 -eq $? ]]; then
		print_ok "$1 Finished"
		$SLEEP
	else
		print_error "$1 Failde"
		exit 1
	fi
}


git clone --depth 1 https://github.com/GabePoel/KvYaru-Colors.git $HOME/kvantum_Yaru_theme
judge "Clone KvYaru repository"

cp -r $HOME/kvantum_Yaru_theme/src/* $HOME/.config/Kvantum/
judge "Copy files to Kvantum directory"

