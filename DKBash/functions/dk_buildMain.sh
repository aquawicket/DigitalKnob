# dk_includeGuard()

##################################################################################
# dk_buildMain()
#
#
dk_buildMain () {
	dk_verbose "dk_buildMain($*)"

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
	dk_validate_sudo
	
	if dk_defined WSLENV; then 
		dk_info "WSLENV is on"
		dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
		sudo chown -R "$LOGNAME" "$HOME"
	fi

	dk_debug SHLVL			# https://stackoverflow.com/a/4511483/688352
	dk_debug MSYSTEM
	dk_debug SCRIPT_PATH
	dk_debug SCRIPT_DIR
	dk_debug SCRIPT_NAME
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_getHostTriple
	
	dk_getDKPaths

	dk_validateGit
	dk_validateBranch

	dk_debug DKBRANCH_DIR
	dk_debug DKAPPS_DIR
	dk_debug DKCMAKE_DIR
	dk_debug DK3RDPARTY_DIR
	dk_debug DKIMPORTS_DIR
	dk_debug DKPLUGINS_DIR

	if [ "$SCRIPT_DIR" != "$DKBRANCH_DIR" ]; then
		dk_warning "$SCRIPT_NAME is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "$SCRIPT_NAME path = $SCRIPT_DIR"
		dk_warning "DKBRANCH_DIR path = $DKBRANCH_DIR"
	fi
	
	while :
	do
		if [ -z "${UPDATE-}" ];     then dk_pickUpdate;  continue; fi
		if [ -z "${APP-}" ];        then dk_pickApp;     continue; fi
		if [ -z "${TARGET_OS-}" ];  then dk_pickOs;      continue; fi
		if [ -z "${TYPE-}" ];       then dk_pickType;    continue; fi
		
		dk_createCache
		dk_generate	
		dk_build
		
		unset UPDATE
		unset APP
		unset TARGET_OS
		unset TYPE
	done
}