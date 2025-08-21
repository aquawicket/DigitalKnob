@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKJavascript(function, arguments...)
::#
::#
:dk_callDKJavascript
%setlocal%
	%dk_call% dk_debugFunc 1 99

	set "_func_=%~1"
	set "_path_=%DKJAVASCRIPT_FUNCTIONS_DIR:\=/%/%_func_%.js"
	
	%dk_call% dk_validate DKJAVASCRIPT_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	if NOT defined DKHTTP_DKJAVASCRIPT_DIR				(set "DKHTTP_DKJAVASCRIPT_DIR=%DKHTTP_DKBRANCH_DIR%/DKJavascript")
	if NOT defined DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR	(set "DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR=%DKHTTP_DKJAVASCRIPT_DIR%/functions")

	if NOT EXIST "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js"	(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js" "%DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js")
	if NOT EXIST "%_path_%"								(%dk_call% dk_download "%DKHTTP_DKJAVASCRIPT_FUNCTIONS_DIR%/%~1.js" "%_path_%")

	%dk_call% dk_allButFirstArgs %*

	set "CSCRIPT_EXE=%windir:\=/%/System32/cscript.exe"
	
	set DKCOMMAND=%ComSpec% /c %CSCRIPT_EXE% //D //E:javascript //H:CScript //I //NoLogo //X %DKJAVASCRIPT_FUNCTIONS_DIR%/DK.js; %DKJAVASCRIPT_FUNCTIONS_DIR%/%1.js; %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKJavascript=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_callDKJavascript dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKJavascript = %dk_callDKJavascript%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKJavascript dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKJavascript = %dk_callDKJavascript%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
