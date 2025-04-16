@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_allButFirstArgs(args)
::#
::#
:dk_allButFirstArgs
setlocal
    %dk_call% dk_debugFunc 1 99

	set dk_allButFirstArgs=%*
	if defined dk_allButFirstArgs (set "dk_allButFirstArgs=!dk_allButFirstArgs:*%1 =!")
	
	endlocal & (
		set "dk_allButFirstArgs=%dk_allButFirstArgs%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    call :DKTEST_funcA abc 123 def 456
	
	call :DKTEST_funcA %dk_allButFirstArgs%
	call :DKTEST_funcA %dk_allButFirstArgs%
	call :DKTEST_funcA %dk_allButFirstArgs%
%endfunction%

:DKTEST_funcA
setlocal
	%dk_call% dk_debugFunc 0 99
	
	echo: 
	echo DKTEST_funcA
	echo  * = %*
	echo ~1 = %~1
	echo ~2 = %~2
	echo ~3 = %~3
	echo ~4 = %~4
	
	%dk_call% dk_allButFirstArgs %*
	endlocal & (
		set "dk_allButFirstArgs=%dk_allButFirstArgs%"
	)
%endfunction%
