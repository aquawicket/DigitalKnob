@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_driveName(<pathname>, <output>:optional)
::#
::#
:dk_driveName
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "pathname=%1"
	set "pathname=%pathname:"=%"
	
:: if "%pathname:~-1%" equ "\" (set "pathname=%pathname:~0,-1%")
:: if "%pathname:~-1%" equ "/" (set "pathname=%pathname:~0,-1%")

	for %%Z in ("%pathname%") do set "dk_driveName=%%~dZ"
	
	endlocal & (
		set "dk_driveName=%dk_driveName%"
		if "%~2" neq "" (set "%~2=%dk_driveName%")
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myPath "C:/Windows"
	%dk_call% dk_driveName "%myPath%" drive
	%dk_call% dk_printVar drive
	
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_driveName "%myPath%" drive
	%dk_call% dk_printVar drive
%endfunction%
