@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_readCache(rtn:APP, rtn:TARGET_OS, rtn:TYPE)
::#
::#
:dk_readCache
 setlocal enableDelayedExpansion
	call dk_debugFunc 3
	
	if "!DE!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
	
	if not defined DKBRANCH_DIR %dk_call% dk_validateBranch
	::%dk_call% dk_printVar DKBRANCH_DIR
    ::if not exist "%DKBRANCH_DIR%\cache" %dk_call% dk_warning "%DKBRANCH_DIR%\cache does not exist" && goto:eof
	if not exist "%DKBRANCH_DIR%\cache" goto:eof
    
	set /a count=0
    for /f "tokens=*" %%a in (%DKBRANCH_DIR%\cache) do (
		if !count! equ 0 set "_APP_=%%a"
        if !count! equ 1 set "_TARGET_OS_=%%a"
        if !count! equ 2 set "_TYPE_=%%a"
		set /a count+=1
    )
	
	endlocal && set "%1=%_APP_%" && set "%2=%_TARGET_OS_%" && set "%3=%_TYPE_%"
	::%dk_call% dk_printVar APP
	::%dk_call% dk_printVar TARGET_OS
	::%dk_call% dk_printVar TYPE
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_readCache APP TARGET_OS TYPE
	%dk_call% dk_printVar APP
	%dk_call% dk_printVar TARGET_OS
	%dk_call% dk_printVar TYPE
goto:eof
