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

get_dk_ostype() {
	DK_OSTYPE=$OSTYPE
	echo "DK_OSTYPE = $DK_OSTYPE"
}

get_dk_model() {
	if [ -e /proc/device-tree/model ]; then
		DK_MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	echo "DK_MODEL = $DK_MODEL"
}

get_dk_machtype() {
	DK_MACHTYPE=$MACHTYPE
	echo "DK_MACHTYPE = $DK_MACHTYPE"
}

get_dk_lang() {
	DK_LANG=$LANG
	echo "DK_LANG = $DK_LANG"
}

get_dk_username() {
	if [[ -n "$USER" ]]; then
		DK_USERNAME=$USER
	elif [[ -n "$USERNAME" ]]; then
		DK_USERNAME=$USERNAME
	fi
	echo "DK_USERNAME = $DK_USERNAME"
}

get_dk_logname() {
	DK_LOGNAME=$LOGNAME
	echo "DK_LOGNAME = $DK_LOGNAME"
}

get_dk_home(){
	DK_HOME=$HOME
	echo "DK_HOME = $DK_HOME"
}

get_dk_term(){
	DK_TERM=$TERM
	echo "DK_TERM = $DK_TERM"
}

get_dk_shell(){
	DK_SHELL=$SHELL
	echo "DK_SHELL = $DK_SHELL"
}

get_dk_path(){
	DK_PATH=$PATH
	echo "DK_PATH = $DK_PATH"
}

get_dk_pwd(){
	DK_PWD=$PWD
	echo "DK_PWD = $DK_PWD"
}

get_dk_root(){
	if [[ -n "$DK_ROOT" ]]; then
		echo "DK_ROOT = $DK_ROOT"
	else
		echo "setting up default DK_ROOT"
		DK_ROOT=$DK_HOME/digitalknob
		export DK_ROOT=$DK_ROOT
		echo "export DK_ROOT=$DK_ROOT" >> ~/.bash_profile
		echo "export DK_ROOT=$DK_ROOT" >> ~/.zshrc
		echo "export DK_ROOT=$DK_ROOT" >> ~/.zprofile
		echo "DK_ROOT = $DK_ROOT"
	fi
}


##################################
#	main
#################################
main(){
	
	get_dk_host
	get_dk_arch
	get_dk_version
	get_dk_ostype
	get_dk_model
	get_dk_machtype
	get_dk_lang
	get_dk_username
	get_dk_logname
	get_dk_home
	get_dk_term
	get_dk_shell
	get_dk_path
	get_dk_pwd
	echo ""
	
	get_dk_root
	
}
main

echo ""