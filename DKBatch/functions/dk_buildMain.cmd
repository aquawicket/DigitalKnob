::dk_includeGuard()
setlocal enableDelayedExpansion

::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain () {
	call dk_verbose "dk_buildMain(%*)"	

::dk_verbose "%var%"

::	echo "BASH = $BASH"
::	if [ $RELOAD_WITH_BASH = 1 ]; then # && ! dk_defined BASH; then
::		export RELOAD_WITH_BASH=0
::		dk_commandExists bash && exec /bin/bash "$0" # Change to bash
::	fi
::	::export PS4=$'+\e[33m ${BASH_SOURCE[0]:-nofile}:${BASH_LINENO[0]:-noline} ${FUNCNAME[0]:-nofunc}()\e[0m  '
::
::	::###### Set and check posix mode ######
::	$(set -o posix) && set -o posix && case :$SHELLOPTS: in
::	  *:posix:*) echo "POSIX mode enabled" ;;
::	  *)         echo "POSIX mode not enabled" ;;
::	esac
::	$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
::	$(set -o errtrace) && set -o errtrace 	# trace ERR through 'time command' and other functions
::	::$(set -o nounset) && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
::	::$(set -o errexit) && set -o errexit  	# set -e : exit the script if any statement returns a non-true
::
::	:: log to stdout and file
::	::exec |& tee file.log 
	
	::call dk_validate_sudo
	
::	if dk_defined WSLENV; then 
::		dk_info "WSLENV is on"
::		dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
::		sudo chown -R "$LOGNAME" "$HOME"
::	fi
	
::	if [ -n "${USER-}" ]; then
::		dk_debug USER
::		DKUSERNAME=$USER
::	elif [ -n "${USERNAME-}" ]; then
::		dk_debug USERNAME
::		DKUSERNAME=$USERNAME
::	fi
::	dk_debug DKUSERNAME
	
::	call dk_debug SHLVL
::  call dk_debug MSYSTEM

	:::::: Get the HOST_TRIPLE and other HOST variables
	call dk_getHostTriple

	call dk_getDKPaths
   
    call dk_validateGit
	call dk_debug GIT_EXE
    call dk_validateBranch

    call dk_debug DKBRANCH_DIR
    call dk_debug DKAPPS_DIR
    call dk_debug DKCMAKE_DIR
    call dk_debug DK3RDPARTY_DIR
    call dk_debug DKIMPORTS_DIR
    call dk_debug DKPLUGINS_DIR
    
	call dk_getDirectory "%SCRIPT_PATH%" SCRIPT_DIR
	
	if NOT "%SCRIPT_DIR%"=="%DKBRANCH_DIR%" (
		call dk_warning "%SCRIPT_NAME% is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		call dk_warning "%SCRIPT_NAME% path = %SCRIPT_DIR%"
		call dk_warning "DKBRANCH_DIR path = %DKBRANCH_DIR%"
	)
    
    :while_loop             
	
		if "%UPDATE%"==""     call dk_pickUpdate & goto:while_loop
		if "%APP%"==""        call dk_pickApp    & goto:while_loop
		if "%TARGET_OS%"==""  call dk_pickOs     & goto:while_loop
		if "%TYPE%"==""       call dk_pickType   & goto:while_loop

		call dk_createCache
		
		call dk_generate
		
		call dk_build
		
		set UPDATE=
		set APP=
		set TARGET_OS=
		set TYPE=
	goto while_loop
goto:eof