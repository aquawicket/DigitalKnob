#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh

clear
echo "NEW DKBUILD SCRIPT FOR UNIX"
echo ""

##################################
#	Functions
#################################

get_dk_host() {
	DK_HOST=$(uname -s)
	echo "DK_HOST = $DK_HOST"
}

get_dk_arch() {
	DK_ARCH=$(uname -m)
	echo "DK_ARCH = $DK_ARCH"
}

get_dk_version() {
	DK_VERSION=$(uname -v)
	echo "DK_VERSION = $DK_VERSION"
}

get_dk_username() {
	if [[ -n "$USER" ]]; then
		DK_USERNAME=$USER
	elif [[ -n "$USERNAME" ]]; then
		DK_USERNAME=$USERNAME
	fi
	echo "DK_USERNAME = $DK_USERNAME"
}

##################################
#	main
#################################
main(){
	
	get_dk_host
	get_dk_arch
	get_dk_version
	get_dk_username
}
main