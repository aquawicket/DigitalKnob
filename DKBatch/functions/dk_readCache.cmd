@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_readCache(rtn:APP, rtn:TARGET_OS, rtn:TYPE)
::#
::#
:dk_readCache
	call dk_debugFunc 3
	
	if not defined DKBRANCH_DIR call dk_validateBranch
	::call dk_printVar DKBRANCH_DIR
    ::if not exist "%DKBRANCH_DIR%\cache" call dk_warning "%DKBRANCH_DIR%\cache does not exist" && goto:eof
	if not exist "%DKBRANCH_DIR%\cache" goto:eof
    
	setlocal enableDelayedExpansion
	if "!!" neq "" call dk_error "%__FUNCTION__% requires delayed expansion"
	
	set /a count=0
    for /f "tokens=*" %%a in (%DKBRANCH_DIR%\cache) do (
		if !count! equ 0 set "APP=%%a"
        if !count! equ 1 set "TARGET_OS=%%a"
        if !count! equ 2 set "TYPE=%%a"
		set /a count+=1
    )
	
	endlocal && set "%1=%APP%" && set "%2=%TARGET_OS%" && set "%3=%TYPE%"
	::call dk_printVar APP
	::call dk_printVar TARGET_OS
	::call dk_printVar TYPE
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_readCache APP TARGET_OS TYPE
	call dk_printVar APP
	call dk_printVar TARGET_OS
	call dk_printVar TYPE
goto:eof
