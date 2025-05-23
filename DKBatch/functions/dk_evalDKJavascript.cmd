@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_evalDKJavascript()
::#
::#
:dk_evalDKJavascript
%setlocal%
	%dk_call% dk_debugFunc 0

	set "CSCRIPT_EXE=%windir:\=/%/System32/cscript.exe"
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	echo %~1 > "%DKCACHE_DIR%/dk_evalJavascript_TEMP.js"
	
	::############ DKJavascript function call ############
	set DKCOMMAND=%ComSpec% /c %CSCRIPT_EXE% //D //E:javascript //H:CScript //I //NoLogo //X "%DKCACHE_DIR%/dk_evalJavascript_TEMP.js";
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_evalDKJavascript=%dk_exec%"
	)

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_evalDKJavascript "WScript.Echo('testing dk_evalDKJavascript');"
%endfunction%

