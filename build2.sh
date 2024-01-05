#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh

# https://blog.opstree.com/2020/02/11/shell-initialization-files/
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

clear

#################################
#	Global variables
#################################
true=0
false=1
END_COLOR="\033[0m"
RED="\033[0;31m"
GREEN='\033[0;32m'
CYAN='\033[0;36'


#################################
#	Functions
#################################

### error <string> ###
function error() {
	echo -e "${RED} ERROR: $1 ${END_COLOR}"
}

### message <string> ###
function message() {
	if [ -z "$1" ]; then
		error "message <string> requires 1 parameter"
		return $false
	fi
	
	echo "$@"	
}

### string_contains <string> <substring> ###
function string_contains() {
	if [ -z "$2" ]; then
		error "string_contains <string] [substring] requires 2 parameters"
		return $false
	fi
	
	[[ $1 == *"$2"* ]]
}

### wait_for_key ###
function wait_for_key() {
	read -n 1 -s -r -p "Press any key to continue"
	echo ""
}

### file_exists <file> ###
function file_exists() {
	if [ -z "$1" ]; then
		error "file_exists <file> requires 1 parameter"
		return $false
	fi
	
	[ -e $1 ]
}

### file_contains <file.ext> <string> ###
function file_contains() {
	if [ -z "$2" ]; then
		error "file_contains <file.ext> <string> requires 2 parameters"
		return $false
	fi
		
	grep -q "$2" "$1"
}

### append_file <string> <file.ext> ###
function append_file() {
	if [ -z "$2" ]; then
		error "append_file <string> <file.ext> requires 2 parameters"
		return $false
	fi
	
	echo "$1" >> $2
}

### remove_from_file <string> <file.ext> ###
function remove_from_file() {
	if [ -z "$2" ]; then
		error "remove_from_file <string> <file.ext> requires 2 parameters"
		return $false
	fi
		
	sed -i -e "/$1/d" $2
}

### command_exists <command> ###
command_exists() {
	if [ -z "$1" ]; then
		error "command_exists <command> requires 1 parameter"
		return $false
	fi
	command -v "$1" >/dev/null 2>&1
}

### get_dk_host ###
function get_dk_host() {
	DK_HOST=$(uname -s)
	echo "DK_HOST = $DK_HOST"
}

### get_dk_arch ###
function get_dk_arch() {
	DK_ARCH=$(uname -m)
	echo "DK_ARCH = $DK_ARCH"
}

### get_dk_version ###
function get_dk_version() {
	DK_VERSION=$(uname -v)
	echo "DK_VERSION = $DK_VERSION"
}

### get_dk_ostype ###
function get_dk_ostype() {
	DK_OSTYPE=$OSTYPE
	echo "DK_OSTYPE = $DK_OSTYPE"
}

### get_dk_model ###
function get_dk_model() {
	if [ -e /proc/device-tree/model ]; then
		DK_MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	echo "DK_MODEL = $DK_MODEL"
}

### get_dk_machtype ###
function get_dk_machtype() {
	DK_MACHTYPE=$MACHTYPE
	echo "DK_MACHTYPE = $DK_MACHTYPE"
}

### get_dk_lang ###
function get_dk_lang() {
	DK_LANG=$LANG
	echo "DK_LANG = $DK_LANG"
}

### get_dk_username ###
function get_dk_username() {
	if [ -n "$USER" ]; then
		DK_USERNAME=$USER
	elif [ -n "$USERNAME" ]; then
		DK_USERNAME=$USERNAME
	fi
	echo "DK_USERNAME = $DK_USERNAME"
}

### get_dk_logname ###
function get_dk_logname() {
	DK_LOGNAME=$LOGNAME
	echo "DK_LOGNAME = $DK_LOGNAME"
}

### get_dk_home ###
function get_dk_home() {
	DK_HOME=$HOME
	echo "DK_HOME = $DK_HOME"
}

### get_dk_prefix ###
function get_dk_prefix() {
	DK_PREFIX=$PREFIX
	echo "DK_PREFIX = $DK_PREFIX"
}

### get_dk_term ###
function get_dk_term() {
	DK_TERM=$TERM
	echo "DK_TERM = $DK_TERM"
}

### get_dk_shell ###
function get_dk_shell() {
	DK_SHELL=$SHELL
	echo "DK_SHELL = $DK_SHELL"
}

### get_dk_path ###
function get_dk_path() {
	DK_PATH=$PATH
	echo "DK_PATH = $DK_PATH"
}

### get_dk_pwd ###
function get_dk_pwd() {
	DK_PWD=$PWD
	echo "DK_PWD = $DK_PWD"
}

### load_dkenv ###
function load_dkenv() {
	touch ~/.dkenv
	source ~/.dkenv
}

### set_dk_root <path> ###
function set_dk_root(){
	if [ -z "$1" ]; then
		error "set_dk_root <path> requires 1 parameter"
		return $false
	fi
	
	DK_ROOT=$1
	export DK_ROOT=$DK_ROOT
	
	touch ~/.dkenv
	remove_from_file DK_ROOT ~/.dkenv
	append_file "export DK_ROOT=$DK_ROOT" ~/.dkenv
	
	echo "DK_ROOT = $DK_ROOT"
}

### get_dk_root ###
function get_dk_root() {
	load_dkenv
	
	if [ -n "$DK_ROOT" ]; then
		echo "DK_ROOT = $DK_ROOT"
	else
		echo "setting DK_ROOT to default directory"
		set_dk_root $DK_HOME/digitalknob
	fi
}

### clear_dk_root ###
function clear_dk_root() {
	export -n DK_ROOT
	unset DK_ROOT
	
	touch ~/.dkenv
	remove_from_file DK_ROOT ~/.dkenv
}


##################################
#	main
#################################
function main() {

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
	get_dk_prefix
	get_dk_term
	get_dk_shell
	get_dk_path
	get_dk_pwd
	echo ""
	
	#clear_dk_root
	get_dk_root
	
	#TODO: Here we need to test that we have enough information to determin what environment we exist on
	
	# HOSTS
	# --------------------------------------------------------------------------------------------------
	# Android (arm32) 	- Termux (LLVM)
	# Android (arm64) 	- Termux (LLVM)
	# Android (x86)	  	- Termux (LLVM)
	# Android (x86_64)	- Termux (LLVM)
	# iOS (arm64)		- iSH (LLVM)
	# Linux (arm32)		- Terminal (GCC, LLVM)
	# Linux (arm64)		- Terminal (GCC, LLVM)
	# Linux (x86)		- Terminal (GCC, LLVM)
	# Linux (x86_64)	- Terminal (GCC, LLVM)
	# Mac (arm32)		- XCode (LLVM)
	# Mac (arm64)		- XCode (LLVM)
	# Mac (x86)			- XCode (LLVM)
	# Mac (x86_64)		- XCode (LLVM)
	# Raspberry (arm32)	- Terminal (GCC, LLVM)
	# Raspberry (arm64)	- Terminal (GCC, LLVM)
	# Raspberry (x86)	- Terminal (GCC, LLVM)
	# Raspberry (x86_64)- Terminal (GCC, LLVM)
	# Windows (arm32)	- VisualStudio (MSVC) 
	# Windows (arm64)	- VisualStudio (MSVC)
	# Windows (x86)		- VisualStudio (MSVC), MINGW32 (GCC), CLANG32 (LLVM)
	# Windows (x86_64)	- VisualStudio (MSVC), MINGW32 (GCC), MINGW64 (GCC), CLANG32 (LLVM), CLANG64 (LLVM), UCRT64 (GCC), CLANGARM64 (LLVM)
	#
	# TARGETS
	# --------------------------------------------------------------------------------------------------
	# Android (arm32)
	# Android (arm64)
	# Android (x86)
	# Android (x86_64)
	# iOS (arm32)
	# iOS (arm64)
	# iOS (x86)
	# iOS (x86_64)
	# iOS-Simulator (arm32)
	# iOS-Simulator (arm64)
	# iOS-Simulator (x86)
	# iOS-Simulator (x86_64)
	# Linux (c)
	# Linux (arm64)
	# Linux (x86)
	# Linux (x86_64)
	# Mac (arm32)
	# Mac (arm64)
	# Mac (x86)
	# Mac (x86_64)
	# Raspberry (arm32)
	# Raspberry (arm64)
	# Raspberry (x86)
	# Raspberry (x86_64)
	# Windows (arm32)
	# Windows (arm64)
	# Windows (x86)
	# Windows (x86_64)
}


# If this script is called with arguments, call the function with arguments, get the return value and exit
if [ $# -ne 0 ]; then
	echo "$1(${@:2}) ->"
	echo ""
	
	"$@"
	
	if [ $? -eq 0 ]; then
		echo ""
		echo -e "-> returned true"
	else
		echo ""
		echo -e "-> returned false"
	fi
	wait_for_key
	exit
fi
main
wait_for_key