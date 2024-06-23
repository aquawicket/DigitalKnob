#!/usr/bin/env bash

# This file is part of eRCaGuy_hello_world: https://github.com/ElectricRCAircraftGuy/eRCaGuy_hello_world

# GS
# Mar. 2022

# Read the keyboard, and output live to the user which key was pressed.
# Status: works!

# keywords: read keyboard; read key

# Check this script with: `shellcheck read_keypress.sh`

# Run command:
#       ./read_keypress.sh

# References:
# 1. [MY ANSwer] https://stackoverflow.com/a/70979348/4561887
ESC=
echo "" > keys.txt
key[0]=""
key[1]=""
key[2]=""
key[3]=""
key[4]=""
key[5]=""
key[6]=""
key[7]=""
key[8]=""
key[9]=""
key[10]=""
key[11]=""
key[12]=""
key[13]=""
key[14]=""
key[15]=""
key[16]=""
key[17]=""
key[18]=""
key[19]=""
key[20]=""
echo "Press any key. Press Ctrl + C to exit."
while true; do
    read -s -n1 c #&& printf "You Pressed: %s\n" "$c"
	#echo "$c" >> keys.txt
	key[0]=${key[1]}
	key[1]=${key[2]}
	key[2]=${key[3]}
	key[3]=${key[4]}
	key[4]=${key[5]}
	key[5]=${key[6]}
	key[6]=${key[7]}
	key[7]=${key[8]}
	key[8]=${key[9]}
	key[9]=${key[10]}
	key[10]=${key[11]}
	key[11]=${key[12]}
	key[12]=${key[13]}
	key[13]=${key[14]}
	key[14]=${key[15]}
	key[15]=${key[16]}
	key[16]=${key[17]}
	key[17]=${key[18]}
	key[18]=${key[19]}
	key[19]=${key[20]}
	key[20]=$c
	#echo "${key[0]}${key[1]}${key[2]}${key[3]}${key[4]}${key[5]}${key[6]}${key[7]}${key[8]}${key[9]}${key[10]}${key[11]}${key[12]}${key[13]}${key[14]}${key[15]}${key[16]}${key[17]}${key[18]}${key[19]}${key[20]}"
	echo "${key[0]}${key[1]}${key[2]}${key[3]}${key[4]}${key[5]}${key[6]}${key[7]}${key[8]}${key[9]}${key[10]}${key[11]}${key[12]}${key[13]}${key[14]}${key[15]}${key[16]}${key[17]}${key[18]}${key[19]}${key[20]}" >> keys.txt

	key5="${key[16]}${key[17]}${key[18]}${key[19]}${key[20]}"
	key3="${key[18]}${key[19]}${key[20]}"
	key1="${key[20]}"

	  if [ "${key1}" = "${ESC}"     ]; then echo "ESC"
	elif [ "${key3}" = "${ESC}OP"   ]; then echo "F1"
	elif [ "${key3}" = "${ESC}OQ"   ]; then echo "F2"  
	elif [ "${key3}" = "${ESC}OR"   ]; then echo "F3"
	elif [ "${key3}" = "${ESC}OS"   ]; then echo "F4"
	elif [ "${key5}" = "${ESC}[15~" ]; then echo "F5"
	elif [ "${key5}" = "${ESC}[17~" ]; then echo "F6"
	elif [ "${key5}" = "${ESC}[18~" ]; then echo "F7"
	elif [ "${key5}" = "${ESC}[19~" ]; then echo "F8"	
	elif [ "${key5}" = "${ESC}[20~" ]; then echo "F9"
	elif [ "${key5}" = "${ESC}[21~" ]; then echo "F10"
	elif [ "${key5}" = "${ESC}[23~" ]; then echo "F11"	
	elif [ "${key5}" = "${ESC}[24~" ]; then echo "F12"
	elif [ "${key1}" = "\`"         ]; then echo "\`"
	elif [ "${key1}" = ""         ]; then echo "Break"
   #elif [ "${key1}" = ""           ]; then echo "PrtSc"
	elif [ "${key1}" = "${ESC}[3~"  ]; then echo "Delete"
	elif [ "${key1}" = "${ESC}[H"   ]; then echo "Home"
	elif [ "${key1}" = ""           ]; then echo ""
	elif [ "${key1}" = ""           ]; then echo ""
	elif [ "${key1}" = ""           ]; then echo ""
	fi

done

