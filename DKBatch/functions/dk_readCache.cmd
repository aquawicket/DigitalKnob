@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_readCache()
::#
::#
:dk_readCache
	call dk_debugFunc
	if %__ARGC__% neq 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments")
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
    if not exist %DKBRANCH_DIR%\cache goto:eof
    set /a count=0

	setlocal enableDelayedExpansion
    for /f "tokens=*" %%a in (%DKBRANCH_DIR%\cache) do (
        set a=%%a: =%
		if !count! equ 0 call dk_set _APP_ "%%a"
        if !count! equ 1 call dk_set _TARGET_OS_ "%%a"
        if !count! equ 2 call dk_set _TYPE_ "%%a"
		set /a count+=1
    )
	endlocal & set "%1=%_APP_%" & set "%2=%_TARGET_OS_%" & set "%3=%_TYPE_%"
goto:eof








::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc
	
	call dk_readCache APP TARGET_OS TYPE
goto:eof
