@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKPowershell(function, arguments...)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKPowershell
%setlocal%
	%dk_call% dk_debugFunc 1 99

	::### Get DKC_FUNCTIONS_DIR
	%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR	"%dk_call% dk_DKBRANCH_DIR"
	if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%"			(%dk_call% dk_mkdir "%DKPOWERSHELL_FUNCTIONS_DIR%")
	%dk_call% dk_assertPath DKPOWERSHELL_FUNCTIONS_DIR

	::### Get DKHTTP_DKPOWERSHELL_DIR
	if NOT defined DKHTTP_DKPOWERSHELL_DIR				(set "DKHTTP_DKPOWERSHELL_DIR=%DKHTTP_DKBRANCH_DIR%/DKPowershell")
	if NOT defined DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR	(set "DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR=%DKHTTP_DKPOWERSHELL_DIR%/functions")

	::### Download files if missing
	if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1"	(%dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1")
	if NOT EXIST "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1"	(%dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1")

	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"

	:: https://stackoverflow.com/a/4732316/688352
	%dk_call% %ComSpec% /c %POWERSHELL_EXE% -Command 'Set-ExecutionPolicy RemoteSigned -Scope CurrentUser' 1>nul

	::### ALL_BUT_FIRST ###	
	%dk_call% dk_allButFirstArgs %*
	
	::############ DKPowershell function call ############
	::%dk_call% %ComSpec% /c %POWERSHELL_EXE% -Command $global:DKSCRIPT_PATH = '%DKSCRIPT_PATH%'; . %DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1; %1 %dk_allButFirstArgs%
	set DKCOMMAND=%POWERSHELL_EXE% -Command "$global:DKSCRIPT_PATH = '%DKSCRIPT_PATH%'; . %DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1; %1 %dk_allButFirstArgs%; Write-Host ${%~1};"
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKPowershell=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKPowershell dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
	
	%dk_call% dk_callDKPowershell Test/dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
	
	%dk_call% dk_callDKPowershell Test/Test/dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPowershell = %dk_callDKPowershell%"
%endfunction%
