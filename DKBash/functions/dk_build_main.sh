#! /bin/bash

#include_guard()

##################################################################################
# dk_build_main()
#
#
function dk_build_main() {
	dk_debug "dk_build_main($@)"
	dk_validate_sudo
	
	if dk_defined WSLENV; then 
		echo "WSLENV is on"
		echo "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
		sudo chown -R $LOGNAME $HOME
	fi
	
	# if dk_command_exists bash; then echo "bash exists"; fi
	# log to stdout and file
	#exec |& tee file.log 

	dk_print_var SHLVL			# https://stackoverflow.com/a/4511483/688352
	dk_print_var HOSTNAME
	dk_print_var HOSTTYPE
	dk_print_var MACHTYPE
	if [ -e /proc/device-tree/model ]; then
		MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	dk_print_var MODEL
	dk_print_var MSYSTEM
	dk_print_var OSTYPE
	dk_print_var SCRIPT_NAME
	dk_print_var SCRIPT_DIR
	dk_print_var USER
	dk_print_var USERNAME
	
	# https://llvm.org/doxygen/Triple_8h_source.html
	if [[ "$MODEL" == "Raspberry"* ]]; then
		HOST_OS="raspberry"
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		HOST_OS="linux"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		HOST_OS="mac"
	elif [[ "$OSTYPE" == "linux-android" ]]; then
		HOST_OS="android"
	elif [[ "$OSTYPE" == "msys" ]]; then
		HOST_OS="win"
	else
		echo "Unknown HOST_OS"
	fi
	dk_print_var HOST_OS
	
	if [[ "$HOSTTYPE" == "x86" ]]; then
		HOST_ARCH="x86"
	elif [[ "$HOSTTYPE" == "x86_64"* ]]; then
		HOST_ARCH="x86_64"
	elif [[ "$HOSTTYPE" == "aarch64"* ]]; then
		HOST_ARCH="arm64"
	else
		echo "Unknown HOST_ARCH"
	fi
	dk_print_var HOST_ARCH
	
	HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	dk_print_var HOST_TRIPLE
	
	if [[ -n "$USERPROFILE" ]]; then
		DIGITALKNOB_DIR="$USERPROFILE\digitalknob"
		DIGITALKNOB_DIR=$(sed 's.C:./c.g' <<< $DIGITALKNOB_DIR)
		DIGITALKNOB_DIR=$(sed 's.\\./.g' <<< $DIGITALKNOB_DIR)
	else
		DIGITALKNOB_DIR="$HOME/digitalknob"
	fi
	mkdir -p $DIGITALKNOB_DIR;
	dk_print_var DIGITALKNOB_DIR

	DKDOWNLOAD_DIR="$DIGITALKNOB_DIR/download"
	mkdir -p $DKDOWNLOAD_DIR;
	dk_print_var DKDOWNLOAD_DIR
	
	DKTOOLS_DIR="$DIGITALKNOB_DIR/DKTools"
	mkdir -p $DKTOOLS_DIR;
	dk_print_var DKTOOLS_DIR

	if [[ "$OSTYPE" == "darwin"* ]]; then
		dk_validate_homebrew
	fi

	#validate_cmake
	dk_validate_git
	dk_validate_branch

	dk_print_var DKBRANCH_DIR
	dk_print_var DKAPPS_DIR
	dk_print_var DKCMAKE_DIR
	dk_print_var DK3RDPARTY_DIR
	dk_print_var DKIMPORTS_DIR
	dk_print_var DKPLUGINS_DIR

	if [ ! $SCRIPT_DIR == $DKBRANCH_DIR ]; then
		dk_warning "$SCRIPT_NAME is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "$SCRIPT_NAME path = $SCRIPT_DIR"
		dk_warning "DKBRANCH_DIR path = $DKBRANCH_DIR"
	fi
	
	while :
	do
		if ! [[ -n "$UPDATE" ]]; then dk_pick_update;	continue; fi
		if ! [[ -n "$APP" ]]; then dk_pick_app;		continue; fi
		if ! [[ -n "$TARGET_OS" ]]; then dk_pick_os;	continue; fi
		if ! [[ -n "$TYPE" ]]; then dk_pick_type;		continue; fi
		
		dk_create_cache
		dk_generate_project
		dk_build_project
		
		unset UPDATE
		unset APP
		unset TARGET_OS
		unset TYPE
	done
}




