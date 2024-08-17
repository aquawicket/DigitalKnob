@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_callPowershell(function, arguments..., return_args...)
::#
::#
:dk_callPowershell
	call dk_debugFunc 1 99
	::call dk_validateArgs PSFunction array array
	
	setlocal
	%dk_call% dk_validate DKPWSH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	
	:: https://stackoverflow.com/a/4732316/688352
	cmd /c powershell Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
	
    ::for /f "usebackq delims=" %%Z in (`powershell . %DKPWSH_FUNCTIONS_DIR%\%~1.ps1; %~1 "%~2"`) do echo %%Z
	echo "%DKPWSH_FUNCTIONS_DIR%\%~1.ps1"
	for /f "usebackq delims=" %%Z in (`set "DKPOWERSHELL_FUNCTIONS_DIR=%DKPWSH_FUNCTIONS_DIR%" ^& powershell %DKPWSH_FUNCTIONS_DIR%\%~1.ps1 %~1 "%~2"`) do echo %%Z
	::%dk_call% dk_echo "PSValue received from Powershell : %PSValue%"
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_callPowershell dk_debug "string from DKBatch"
	::%dk_call% dk_callPowershell dk_debug "string from DKBatch" rtnVar
goto:eof
