@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKHta(function, arguments...)
::#
::#
:dk_callDKHta
%setlocal%
	%dk_call% dk_debugFunc 1 99

	::### Get DKHTA_FUNCTIONS_DIR
	%dk_call% dk_validate DKHTA_FUNCTIONS_DIR  "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKHTA_FUNCTIONS_DIR
	if not defined DKHTTP_DKHTA_DIR				(set "DKHTTP_DKHTA_DIR=%DKHTTP_DKBRANCH_DIR%/DKHTA")
	if not defined DKHTTP_DKHTA_FUNCTIONS_DIR	(set "DKHTTP_DKHTA_FUNCTIONS_DIR=%DKHTTP_DKHTA_DIR%/functions")
	::### Download files if missing
	if not exist %DKHTA_FUNCTIONS_DIR%/DK.hta		(%dk_call% dk_download "%DKHTTP_DKHTA_FUNCTIONS_DIR%/DK.hta" "%DKHTA_FUNCTIONS_DIR%/DK.hta")
	if not exist %DKHTA_FUNCTIONS_DIR%/%~1.hta	(%dk_call% dk_download "%DKHTTP_DKHTA_FUNCTIONS_DIR%/%~1.hta" "%DKHTA_FUNCTIONS_DIR%/%~1.hta")

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	set "MSHTA_EXE=%windir:\=/%/System32/mshta.exe"
	
	::############ DKHta function call ############
	set DKCOMMAND=%ComSpec% /c %DKHTA_FUNCTIONS_DIR%/%1.hta; %dk_allButFirstArgs%
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKHta=%dk_exec%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKHta dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKHta = %dk_callDKHta%"
%endfunction%
