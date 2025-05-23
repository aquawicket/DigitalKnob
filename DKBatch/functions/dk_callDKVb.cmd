@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKVb(function, arguments...)
::#
::#
:dk_callDKVb
%setlocal%
	%dk_call% dk_debugFunc 1 99

	::### Get DKVB_FUNCTIONS_DIR
	%dk_call% dk_validate DKVB_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKVB_FUNCTIONS_DIR
	if not defined DKHTTP_DKVB_DIR				(set "DKHTTP_DKVB_DIR=%DKHTTP_DKBRANCH_DIR%/DKVb")
	if not defined DKHTTP_DKVB_FUNCTIONS_DIR	(set "DKHTTP_DKVB_FUNCTIONS_DIR=%DKHTTP_DKVB_DIR%/functions")
	::### Download files if missing
	if not exist %DKVB_FUNCTIONS_DIR%/DK.vbs	(%dk_call% dk_download "%DKHTTP_DKVB_FUNCTIONS_DIR%/DK.vbs" "%DKVB_FUNCTIONS_DIR%/DK.vbs")
	if not exist %DKVB_FUNCTIONS_DIR%/%~1.vbs	(%dk_call% dk_download "%DKHTTP_DKVB_FUNCTIONS_DIR%/%~1.vbs" "%DKVB_FUNCTIONS_DIR%/%~1.vbs")

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	set "CSCRIPT_EXE=%windir:\=/%/System32/cscript.exe"
	
	::############ DKVb function call ############
	set DKCOMMAND=%ComSpec% /c %CSCRIPT_EXE% //D //E:VBScript //H:CScript //I //NoLogo //X %DKVB_FUNCTIONS_DIR%/DK.vbs; %DKVB_FUNCTIONS_DIR%/%1.vbs; %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKVb=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKVb dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKVb = %dk_callDKVb%"
%endfunction%
