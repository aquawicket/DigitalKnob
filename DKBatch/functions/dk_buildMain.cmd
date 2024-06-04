@echo off
call DK

::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

setlocal enableDelayedExpansion
	
::	if dk_defined WSLENV; then 
::		dk_info "WSLENV is on"
::		dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
::		sudo chown -R "$LOGNAME" "$HOME"
::	fi
	
::	if [ -n "${USER-}" ]; then
::		call dk_printVar USER
::		DKUSERNAME=$USER
::	elif [ -n "${USERNAME-}" ]; then
::		call dk_printVar USERNAME
::		DKUSERNAME=$USERNAME
::	fi
::	call dk_printVar DKUSERNAME
	
::	call dk_printVar SHLVL
::  call dk_printVar MSYSTEM

	:::::: Get the HOST_TRIPLE and other HOST variables
	call dk_load dk_getHostTriple
	call dk_getHostTriple
	
	call dk_load dk_getDKPaths
	call dk_getDKPaths
   
	call dk_load dk_validateGit
    call dk_validateGit
	
	call dk_load dk_validateBranch
    call dk_validateBranch
    
	call dk_getDirname "%DKSCRIPT_PATH%" DKSCRIPT_DIR
	
	call dk_load dk_warning
	if "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%" (
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
		
		call dk_unset UPDATE
		call dk_unset APP
		call dk_unset TARGET_OS
		call dk_unset TYPE
	goto while_loop
	endlocal
goto:eof



:DKTEST ########################################################################

	call dk_buildMain