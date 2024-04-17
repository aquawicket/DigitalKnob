# dk_include_guard()

##################################################################################
# dk_build_main()
#
#
dk_build_main () {
	dk_verbose "dk_build_main($*)"

	echo "BASH = $BASH"
	if [ $RELOAD_WITH_BASH = 1 ]; then # && ! dk_defined BASH; then
		export RELOAD_WITH_BASH=0
		dk_command_exists bash && exec /bin/bash "$0" # Change to bash
	fi
	#export PS4=$'+\e[33m ${BASH_SOURCE[0]:-nofile}:${BASH_LINENO[0]:-noline} ${FUNCNAME[0]:-nofunc}()\e[0m  '

	###### Set and check posix mode ######
	$(set -o posix) && set -o posix && case :$SHELLOPTS: in
	  *:posix:*) echo "POSIX mode enabled" ;;
	  *)         echo "POSIX mode not enabled" ;;
	esac
	$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
	$(set -o errtrace) && set -o errtrace 	# trace ERR through 'time command' and other functions
	#$(set -o nounset) && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
	#$(set -o errexit) && set -o errexit  	# set -e : exit the script if any statement returns a non-true

	# log to stdout and file
	#exec |& tee file.log 
	
	dk_validate_sudo
	
	if dk_defined WSLENV; then 
		dk_info "WSLENV is on"
		dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
		sudo chown -R "$LOGNAME" "$HOME"
	fi

	#if [ -n "${USER-}" ]; then
	#	dk_debug USER
	#	DKUSERNAME=$USER
	#elif [ -n "${USERNAME-}" ]; then
	#	dk_debug USERNAME
	#	DKUSERNAME=$USERNAME
	#fi
	#dk_debug DKUSERNAME
	
	dk_debug DUMMY
	dk_debug 3jd-6
	dk_debug SHLVL			# https://stackoverflow.com/a/4511483/688352
	dk_debug MSYSTEM
	dk_debug SCRIPT_NAME
	dk_debug SCRIPT_DIR
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_get_host_triple
	
	dk_get_dkpaths

	dk_validate_git
	dk_validate_branch

	dk_debug DKBRANCH_DIR
	dk_debug DKAPPS_DIR
	dk_debug DKCMAKE_DIR
	dk_debug DK3RDPARTY_DIR
	dk_debug DKIMPORTS_DIR
	dk_debug DKPLUGINS_DIR

	if [ ! "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
		dk_warning "$SCRIPT_NAME is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "$SCRIPT_NAME path = $SCRIPT_DIR"
		dk_warning "DKBRANCH_DIR path = $DKBRANCH_DIR"
	fi
	
	while :
	do
		if [ -z "${UPDATE-}" ];     then dk_pick_update;  continue; fi
		if [ -z "${APP-}" ];        then dk_pick_app;     continue; fi
		if [ -z "${TARGET_OS-}" ];  then dk_pick_os;      continue; fi
		if [ -z "${TYPE-}" ];       then dk_pick_type;    continue; fi
		
		dk_create_cache
		
		dk_generate
		
		dk_build
		
		unset UPDATE
		unset APP
		unset TARGET_OS
		unset TYPE
	done
}