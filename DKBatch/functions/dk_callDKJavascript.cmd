@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callDKJavascript(function, arguments...)
::#
::#
:dk_callDKJavascript
setlocal
	%dk_call% dk_debugFunc 1 99

	::### Get DKJAVASCRIPT_FUNCTIONS_DIR
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR
	if not defined DKHTTP_DKJAVASCRIPT_DIR				(set "DKHTTP_DKJAVASCRIPT_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if not defined DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR	(set "DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR=%DKHTTP_DKJAVASCRIPT_DIR%/functions")

	::### Download files if missing
	if not exist %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js		(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js")
	if not exist %DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js	(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js")

	::### ALL_BUT_FIRST ###
	set "ALL_BUT_FIRST=%*"
	if defined ALL_BUT_FIRST (set "ALL_BUT_FIRST=!ALL_BUT_FIRST:%~1 =!")

	set "CSCRIPT_EXE=C:/Windows/System32/cscript.exe"
	set DKJAVASCRIPT_COMMAND=%COMSPEC% /c %CSCRIPT_EXE% //D //E:javascript //H:CScript //I //NoLogo //X %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js; %DKJAVASCRIPT_FUNCTIONS_DIR%/%1.js; %ALL_BUT_FIRST%

	
	%dk_call% dk_exec %DKJAVASCRIPT_COMMAND%
	endlocal & (
		set "dk_callDKJavascript=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKJavascript dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKJavascript = %dk_callDKJavascript%"
%endfunction%
