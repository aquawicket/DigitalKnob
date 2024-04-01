#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh

# https://blog.opstree.com/2020/02/11/shell-initialization-files/
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/




###### test <...> ######
function test() {
	echo "############ test() ############"
	dk_print_var BASH
	dk_print_var BASHOPTS
	dk_print_var FUNCNAME
	dk_print_var FUNCNAME
	dk_print_var FUNCNAME
	dk_print_var LINENO
	dk_print_var BASH_SOURCE
	dk_print_var BASH_LINENO
}


#################################
#		Functions
#################################

###### dk_get_uname ######
function dk_get_uname() {
	DK_UNAME=$(uname -a)
	dk_print_var DK_UNAME
}

###### dk_get_host ######
function dk_get_host() {
	DK_HOST=$(uname -s)
	dk_print_var DK_HOST
}

###### dk_get_arch ######
function dk_get_arch() {
	DK_ARCH=$(uname -m)
	dk_print_var DK_ARCH
}

###### dk_get_version ######
function dk_get_version() {
	DK_VERSION=$(uname -v)
	dk_print_var DK_VERSION
}

###### dk_get_ostype ######
function dk_get_ostype() {
	DK_OSTYPE=$OSTYPE
	dk_print_var DK_OSTYPE
}

###### dk_get_cpuinfo ######
function dk_get_cpuinfo() {
	if [ -e /proc/cpuinfo ]; then
		DK_CPUINFO=$(tr -d '\0' </proc/cpuinfo)
	fi
	dk_print_var DK_CPUINFO
}

###### dk_get_model ######
function dk_get_model() {
	if [ -e /proc/device-tree/model ]; then
		DK_MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	dk_print_var DK_MODEL
}

###### dk_get_machtype ######
function dk_get_machtype() {
	DK_MACHTYPE=$MACHTYPE
	dk_print_var DK_MACHTYPE
}

###### dk_get_lang ######
function dk_get_lang() {
	DK_LANG=$LANG
	dk_print_var DK_LANG
}

###### dk_get_username ######
function dk_get_username() {
	if [ -n "$USER" ]; then
		DK_USERNAME=$USER
	elif [ -n "$USERNAME" ]; then
		DK_USERNAME=$USERNAME
	fi
	dk_print_var DK_USERNAME
}

###### dk_get_logname ######
function dk_get_logname() {
	DK_LOGNAME=$LOGNAME
	dk_print_var DK_LOGNAME
}

###### dk_get_home ######
function dk_get_home() {
	DK_HOME=$HOME
	dk_print_var DK_HOME
}

###### dk_get_prefix ######
function dk_get_prefix() {
	DK_PREFIX=$PREFIX
	dk_print_var DK_PREFIX
}

###### dk_get_term ######
function dk_get_term() {
	DK_TERM=$TERM
	dk_print_var DK_TERM
}

###### dk_get_shell ######
function dk_get_shell() {
	DK_SHELL=$SHELL
	dk_print_var DK_SHELL
}

###### dk_get_path ######
function dk_get_path() {
	DK_PATH=$PATH
	dk_print_var DK_PATH
}

###### dk_get_pwd ######
function dk_get_pwd() {
	DK_PWD=$PWD
	dk_print_var DK_PWD
}

###### load_dkenv ######
function load_dkenv() {
	touch ~/.dkenv
	source ~/.dkenv
}

###### set_dk_root <path> ######
function set_dk_root(){
	if [ -z "$1" ]; then
		dk_error "set_dk_root <path> requires 1 parameter"
		return $false
	fi
	
	DK_ROOT=$1
	export DK_ROOT=$DK_ROOT
	
	touch ~/.dkenv
	dk_remove_from_file DK_ROOT ~/.dkenv
	dk_append_file "export DK_ROOT=$DK_ROOT" ~/.dkenv
	
	dk_print_var DK_ROOT
}

###### dk_get_root ######
function dk_get_root() {
	load_dkenv
	
	if [ -n "$DK_ROOT" ]; then
		dk_print_var DK_ROOT
	else
		echo "setting DK_ROOT to default directory"
		set_dk_root $DK_HOME/digitalknob
	fi
}

###### dk_clear_root ######
function dk_clear_root() {
	export -n DK_ROOT
	unset DK_ROOT
	
	touch ~/.dkenv
	remove_from_file DK_ROOT ~/.dkenv
}


##################################
#	main
#################################
function main() {

	dk_get_uname
	dk_get_host
	dk_get_arch
	dk_get_version
	dk_get_ostype
	#dk_get_cpuinfo
	dk_get_model
	dk_get_machtype
	dk_get_lang
	dk_get_username
	dk_get_logname
	dk_get_home
	dk_get_prefix
	dk_get_term
	dk_get_shell
	dk_get_path
	dk_get_pwd
	echo ""
	
	#dk_clear_root
	dk_get_root
	
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
	dk_wait_for_key
	exit
fi
main
dk_wait_for_key