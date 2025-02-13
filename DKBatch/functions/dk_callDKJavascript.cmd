@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_callDKJavascript(function, arguments..., rtn_var)
::#
::#
:dk_callDKJavascript
setlocal
    %dk_call% dk_debugFunc 1 99
 
	::### Get DKJAVASCRIPT_FUNCTIONS_DIR
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR  "%dk_call% dk_DKJAVASCRIPT_FUNCTIONS_DIR"
	if not exist "%DKJAVASCRIPT_FUNCTIONS_DIR%"			(set "DKJAVASCRIPT_FUNCTIONS_DIR=%CD%/DKJavascript/functions")
	if not exist "%DKJAVASCRIPT_FUNCTIONS_DIR%"			(mkdir "%DKJAVASCRIPT_FUNCTIONS_DIR%")
	%dk_call% dk_assertPath DKJAVASCRIPT_FUNCTIONS_DIR
	
	::### Get DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR
	if not defined DKHTTP_DKJAVASCRIPT_DIR				(set "DKHTTP_DKJAVASCRIPT_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if not defined DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR	(set "DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR=%DKHTTP_DKJAVASCRIPT_DIR%/functions")
	
	::### Download files if missing
	if not exist %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js		(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js")
	if not exist %DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js	(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js")

	:: TODO
	%dk_call% dk_todo "dk_callDKJavascript"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKJavascript dk_echo "This is a string from DKJavascript dk_echo" rtn_var
    %dk_call% dk_echo
	if defined rtn_var (%dk_call% dk_echo "rtn_var = %rtn_var%")
%endfunction%
