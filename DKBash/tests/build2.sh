#!/bin/sh

# https://blog.opstree.com/2020/02/11/shell-initialization-files/
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

###### Load DK Function files (DKINIT) ######
. ../functions/DK


###### test <...> ######
test() {
	dk_echo "############ test() ############"
	dk_printVar BASH
	dk_printVar BASHOPTS
	dk_printVar FUNCNAME
	dk_printVar FUNCNAME
	dk_printVar FUNCNAME
	dk_printVar LINENO
	dk_printVar BASH_SOURCE
	dk_printVar BASH_LINENO
}


#################################
#		Functions
#################################

###### get_uname ######
get_uname() {
	DKUNAME=$(uname -a)
	dk_printVar DKUNAME
}

###### get_host ######
get_host() {
	DKHOST=$(uname -s)
	dk_printVar DKHOST
}

###### get_arch ######
get_arch() {
	DKARCH=$(uname -m)
	dk_printVar DKARCH
}

###### get_version ######
get_version() {
	DKVERSION=$(uname -v)
	dk_printVar DKVERSION
}

###### get_ostype ######
get_ostype() {
	DKOSTYPE=$OSTYPE
	dk_printVar DKOSTYPE
}

###### get_cpuinfo ######
get_cpuinfo() {
	if [ -e /proc/cpuinfo ]; then
		DKCPUINFO=$(tr -d '\0' </proc/cpuinfo)
	fi
	dk_printVar DKCPUINFO
}

###### get_model ######
get_model() {
	if [ -e /proc/device-tree/model ]; then
		DKMODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	dk_printVar DKMODEL
}

###### get_machtype ######
get_machtype() {
	DKMACHTYPE=${MACHTYPE}
	dk_printVar DKMACHTYPE
}

###### get_lang ######
get_lang() {
	DKLANG=${LANG}
	dk_printVar DKLANG
}

###### get_username ######
get_username() {
	if [ -n "${USER}" ]; then
		DKUSERNAME=${USER}
	elif [ -n "${USERNAME}" ]; then
		DKUSERNAME=${USERNAME}
	fi
	dk_printVar DKUSERNAME
}

###### get_logname ######
get_logname() {
	DKLOGNAME=$LOGNAME
	dk_printVar DKLOGNAME
}

###### get_home ######
get_home() {
	DKHOME=$HOME
	dk_printVar DKHOME
}

###### get_prefix ######
get_prefix() {
	DKPREFIX=$PREFIX
	dk_printVar DKPREFIX
}

###### get_term ######
get_term() {
	DKTERM=$TERM
	dk_printVar DKTERM
}

###### get_shell ######
get_shell() {
	DKSHELL=${SHELL}
	dk_printVar DKSHELL
}

###### get_path ######
get_path() {
	DKPATH=$PATH
	dk_printVar DKPATH
}

###### get_pwd ######
get_pwd() {
	DKPWD=$PWD
	dk_printVar DKPWD
}

###### load_dkenv ######
load_dkenv() {
	touch ~/.dkenv
	source ~/.dkenv
}

###### set_dkroot <path> ######
set_dkroot(){
	if [ -z "${1}" ]; then
		dk_error "set_dkroot <path> requires 1 parameter"
		return ${false}
	fi
	
	DKROOT=${1}
	export DKROOT=$DKROOT
	
	touch ~/.dkenv
	dk_removeFromFile DKROOT ~/.dkenv
	dk_appendFile "export DKROOT=$DKROOT" ~/.dkenv
	
	dk_printVar DKROOT
}

###### get_root ######
get_root() {
	load_dkenv
	
	if [ -n "$DKROOT" ]; then
		dk_printVar DKROOT
	else
		echo "setting DKROOT to default directory"
		set_dkroot $DKHOME/digitalknob
	fi
}

###### clear_root ######
clear_root() {
	export -n DKROOT
	unset DKROOT
	
	touch ~/.dkenv
	remove_from_file DKROOT ~/.dkenv
}


##################################
#	main
#################################
main() {

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
if [ ${#} -ne 0 ]; then
	echo "$1(${@:2}) ->"
	echo ""
	
	"${@}"
	
	if [ ${?} -eq 0 ]; then
		echo ""
		echo -e "-> returned true"
	else
		echo ""
		echo -e "-> returned false"
	fi
	dk_pause
	exit
fi
main

dk_pause