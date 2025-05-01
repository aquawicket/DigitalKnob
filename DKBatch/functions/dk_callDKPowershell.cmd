@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callPowershell(function, arguments...)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callPowershell
%setlocal%
	%dk_call% dk_debugFunc 1 99

	::### Get DKC_FUNCTIONS_DIR
	%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR	"%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKPOWERSHELL_FUNCTIONS_DIR%"			(mkdir "%DKPOWERSHELL_FUNCTIONS_DIR:/=\%")
	%dk_call% dk_assertPath DKPOWERSHELL_FUNCTIONS_DIR

	::### Get DKHTTP_DKPOWERSHELL_DIR
	if not defined DKHTTP_DKPOWERSHELL_DIR				(set "DKHTTP_DKPOWERSHELL_DIR=%DKHTTP_DKBRANCH_DIR%/DKPowershell")
	if not defined DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR	(set "DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR=%DKHTTP_DKPOWERSHELL_DIR%/functions")

	::### Download files if missing
	if not exist "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1"	(%dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1")
	if not exist "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1"	(%dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1")

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"

	:: https://stackoverflow.com/a/4732316/688352
	%dk_call% %ComSpec% /c %POWERSHELL_EXE% -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

	::### ALL_BUT_FIRST ###
	%dk_call% dk_allButFirstArgs %*
	
	::############ DKPowershell function call ############
	set DKCOMMAND=%POWERSHELL_EXE% -Command $global:DKSCRIPT_PATH = '%DKSCRIPT_PATH%'; . %DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1; %1 %dk_allButFirstArgs%
	%dk_call% dk_exec "%DKCOMMAND%"
	endlocal & (
		set "dk_callPowershell=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKPowershell dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callPowershell = %dk_callPowershell%"
%endfunction%
