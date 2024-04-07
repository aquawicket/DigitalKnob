#!/bin/bash

# https://blog.opstree.com/2020/02/11/shell-initialization-files/
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

###### Load DK Function files (DKINIT) ######
source ../functions/DK.sh


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

###### get_uname ######
function get_uname() {
	DKUNAME=$(uname -a)
	dk_print_var DKUNAME
}

###### get_host ######
function get_host() {
	DKHOST=$(uname -s)
	dk_print_var DKHOST
}

###### get_arch ######
function get_arch() {
	DKARCH=$(uname -m)
	dk_print_var DKARCH
}

###### get_version ######
function get_version() {
	DKVERSION=$(uname -v)
	dk_print_var DKVERSION
}

###### get_ostype ######
function get_ostype() {
	DKOSTYPE=$OSTYPE
	dk_print_var DKOSTYPE
}

###### get_cpuinfo ######
function get_cpuinfo() {
	if [ -e /proc/cpuinfo ]; then
		DKCPUINFO=$(tr -d '\0' </proc/cpuinfo)
	fi
	dk_print_var DKCPUINFO
}

###### get_model ######
function get_model() {
	if [ -e /proc/device-tree/model ]; then
		DKMODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	dk_print_var DKMODEL
}

###### get_machtype ######
function get_machtype() {
	DKMACHTYPE=$MACHTYPE
	dk_print_var DKMACHTYPE
}

###### get_lang ######
function get_lang() {
	DKLANG=$LANG
	dk_print_var DKLANG
}

###### get_username ######
function get_username() {
	if [ -n "$USER" ]; then
		DKUSERNAME=$USER
	elif [ -n "$USERNAME" ]; then
		DKUSERNAME=$USERNAME
	fi
	dk_print_var DKUSERNAME
}

###### get_logname ######
function get_logname() {
	DKLOGNAME=$LOGNAME
	dk_print_var DKLOGNAME
}

###### get_home ######
function get_home() {
	DKHOME=$HOME
	dk_print_var DKHOME
}

###### get_prefix ######
function get_prefix() {
	DKPREFIX=$PREFIX
	dk_print_var DKPREFIX
}

###### get_term ######
function get_term() {
	DKTERM=$TERM
	dk_print_var DKTERM
}

###### get_shell ######
function get_shell() {
	DKSHELL=$SHELL
	dk_print_var DKSHELL
}

###### get_path ######
function get_path() {
	DKPATH=$PATH
	dk_print_var DKPATH
}

###### get_pwd ######
function get_pwd() {
	DKPWD=$PWD
	dk_print_var DKPWD
}

###### load_dkenv ######
function load_dkenv() {
	touch ~/.dkenv
	source ~/.dkenv
}

###### set_dkroot <path> ######
function set_dkroot(){
	if [ -z "$1" ]; then
		dk_error "set_dkroot <path> requires 1 parameter"
		return $false
	fi
	
	DKROOT=$1
	export DKROOT=$DKROOT
	
	touch ~/.dkenv
	dk_remove_from_file DKROOT ~/.dkenv
	dk_append_file "export DKROOT=$DKROOT" ~/.dkenv
	
	dk_print_var DKROOT
}

###### get_root ######
function get_root() {
	load_dkenv
	
	if [ -n "$DKROOT" ]; then
		dk_print_var DKROOT
	else
		echo "setting DKROOT to default directory"
		set_dkroot $DKHOME/digitalknob
	fi
}

###### clear_root ######
function clear_root() {
	export -n DKROOT
	unset DKROOT
	
	touch ~/.dkenv
	remove_from_file DKROOT ~/.dkenv
}


##################################
#	main
#################################
function main() {

	get_uname
	get_host
	get_arch
	get_version
	get_ostype
	#get_cpuinfo
	get_model
	get_machtype
	get_lang
	get_username
	get_logname
	get_home
	get_prefix
	get_term
	get_shell
	get_path
	get_pwd
	echo ""
	
	#clear_root
	get_root
	
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