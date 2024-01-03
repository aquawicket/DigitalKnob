#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh

clear
echo "NEW DKBUILD SCRIPT FOR UNIX"
echo ""

##################################
#	Functions
#################################

### file_exists [file.ext]
file_exists() {
	#echo "file_exists($1)"
	[ -e $1 ]
}

file_contains() {
	grep -q "$1" "$2"
}

### append_file ["string"] [file.ext]
append_file() {
	#echo "append_file($1, $2)"
	echo "$1" >> $2
	#echo "appended \"$1\" to $2s"
}

### remove_from_file [string] [file.ext]
remove_from_file() {
	sed -i -e "/$1/d" $2
}

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

reload_environment(){
	if file_exists ~/.zprofile; then
		unset DK_ROOT
		source ~/.zprofile
		#exec zsh -l
	fi
}

### set_env [var] [value]	TODO
set_env(){
	echo "set_env($1 $2)"
	
	## zsh
	if file_exists ~/.zprofile; then
		remove_from_file $1 ~/.zprofile
		append_file "export $1=$2" ~/.zprofile
		reload_environment
	fi
	
	echo "$1 = $2"
}

### get_env [var] 	TODO
get_env(){
	echo "get_env(\$1)"
	if [[ -n "\$1" ]]; then
		echo "\$1 = $1"
		#else
		#echo "setting up default DK_ROOT"
		#DK_ROOT=$DK_HOME/digitalknob
		#set_dk_root $DK_ROOT
	fi
}


### set_dk_root [path/to/digitalknob]
set_dk_root(){
	echo "set_dk_root($1)"
	DK_ROOT=$1
	
	## bash, ksh, bourne
	#if file_exists ~/.profile; then
	#	remove_from_file DK_ROOT ~/.profile
	#	append_file "export DK_ROOT=$DK_ROOT" ~/.profile
	#fi
	
	## bash
	#if file_exists ~/.bash_profile; then
	#	remove_from_file DK_ROOT ~/.bash_profile
	#	append_file "export DK_ROOT=$DK_ROOT" ~/.bash_profile
	#fi
	#if file_exists ~/.bashrc; then
	#	remove_from_file DK_ROOT ~/.bashrc
	#	append_file "export DK_ROOT=$DK_ROOT" ~/.bashrc
	#fi
	
	## zsh
	if file_exists ~/.zprofile; then
		remove_from_file DK_ROOT ~/.zprofile
		append_file "export DK_ROOT=$DK_ROOT" ~/.zprofile
	fi
	#if file_exists ~/.zshrc; then
	#	remove_from_file DK_ROOT ~/.zshrc
	#	append_file "export DK_ROOT=$DK_ROOT" ~/.zshrc
	#fi
	
	## csh, tcsh
	#if file_exists ~/.login; then
	#	remove_from_file DK_ROOT ~/.login
	#	append_file "export DK_ROOT=$DK_ROOT" ~/.login
	#fi
	
	echo "DK_ROOT = $DK_ROOT"
}

get_dk_root(){
	echo "get_dk_root()"
	if [[ -n "$DK_ROOT" ]]; then
		echo "DK_ROOT = $DK_ROOT"
	else
		echo "setting DK_ROOT to default directory"
		set_dk_root $DK_HOME/digitalknob
	fi
}





##################################
#	main
#################################
main(){
	echo "main()"
	
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
	
	#remove_from_file DK ~/.zprofile
	#reload_environment
	
	get_dk_root
}
main

echo ""