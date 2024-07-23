@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_readCache(rtn:APP, rtn:TARGET_OS, rtn:TYPE)
::#
::#
:dk_readCache
	call dk_debugFunc
	if %__ARGC__% neq 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if not defined DKBRANCH_DIR call dk_validateBranch
    if not exist "%DKBRANCH_DIR%\cache" call dk_warning "%DKBRANCH_DIR%\cache does not exist" && goto:eof
    
	setlocal enableDelayedExpansion
	if "!!" neq "" call dk_error "%__FUNCTION__% requires delayed expansion"
	
	set /a count=0
    for /f "tokens=*" %%a in ("%DKBRANCH_DIR%\cache") do (
		if !count! equ 0 set "APP=%%a"
        if !count! equ 1 set "TARGET_OS=%%a"
        if !count! equ 2 set "TYPE=%%a"
		set /a count+=1
    )
	
	::call dk_printVar APP
	::call dk_printVar TARGET_OS
	::call dk_printVar TYPE
	
	endlocal & set "%1=%APP%" & set "%2=%TARGET_OS%" & set "%3=%TYPE%"
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_readCache APP TARGET_OS TYPE
goto:eof
