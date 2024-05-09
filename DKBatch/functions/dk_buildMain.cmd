@echo off
call DK

::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"

setlocal enableDelayedExpansion
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
::		dk_printVar USER
::		DKUSERNAME=$USER
::	elif [ -n "${USERNAME-}" ]; then
::		dk_printVar USERNAME
::		DKUSERNAME=$USERNAME
::	fi
::	dk_printVar DKUSERNAME
	
::	call dk_printVar SHLVL
::  call dk_printVar MSYSTEM

	:::::: Get the HOST_TRIPLE and other HOST variables
	call dk_load dk_getHostTriple
	call dk_getHostTriple
	
	call dk_load dk_getDKPaths
	call dk_getDKPaths
   
	call dk_load dk_validateGit
    call dk_validateGit
	call dk_printVar GIT_EXE
	
	call dk_load dk_validateBranch
    call dk_validateBranch

    call dk_printVar DKBRANCH_DIR
    call dk_printVar DKAPPS_DIR
    call dk_printVar DKCMAKE_DIR
    call dk_printVar DK3RDPARTY_DIR
    call dk_printVar DKIMPORTS_DIR
    call dk_printVar DKPLUGINS_DIR
    
	call dk_getDirectory "%DKSCRIPT_PATH%" DKSCRIPT_DIR
	
	call dk_load dk_warning
	if NOT "%DKSCRIPT_DIR%"=="%DKBRANCH_DIR%" (
		call dk_warning "%DKSCRIPT_NAME% is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		call dk_warning "%DKSCRIPT_NAME% path = %DKSCRIPT_DIR%"
		call dk_warning "DKBRANCH_DIR path = %DKBRANCH_DIR%"
	)
    
	call dk_load dk_pickUpdate
	call dk_load dk_pickApp
	call dk_load dk_pickOs
	call dk_load dk_pickType
	call dk_load dk_createCache
	call dk_load dk_generate
	call dk_load dk_build
	call dk_load dk_readCache
	call dk_load dk_checkGitRemote
	
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
	endlocal
goto:eof