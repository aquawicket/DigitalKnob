@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_callPowershell(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callPowershell
    call dk_debugFunc 1 99
 setlocal
	
	::%dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	::if not exist "%DKPOWERSHELL_FUNCTIONS_DIR%" set "DKPOWERSHELL_FUNCTIONS_DIR=%CD%\DKPowershell\functions"
	if not defined DKPOWERSHELL_FUNCTIONS_DIR  if exist %HOMEDRIVE%%HOMEPATH%\digitalknob\Development\.git  set "DKPOWERSHELL_FUNCTIONS_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\DKPowershell\functions"
	if not defined DKPOWERSHELL_FUNCTIONS_DIR  set "DKPOWERSHELL_FUNCTIONS_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob\DKTools\DKPowershell\functions"
	if not exist "%DKPOWERSHELL_FUNCTIONS_DIR%" mkdir "%DKPOWERSHELL_FUNCTIONS_DIR%"
	if not defined DKHTTP_DKPOWERSHELL_DIR            set "DKHTTP_DKPOWERSHELL_DIR=%DKHTTP_DKBRANCH_DIR%/DKPowershell"
	if not defined DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR  set "DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR=%DKHTTP_DKPOWERSHELL_DIR%/functions"
	if not exist %DKPOWERSHELL_FUNCTIONS_DIR%\DK.ps1 %dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/DK.ps1"
	if not exist %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1 %dk_call% dk_download "%DKHTTP_DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1" "%DKPOWERSHELL_FUNCTIONS_DIR%/%~1.ps1"
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
    
	:: https://stackoverflow.com/a/4732316/688352
    call %ComSpec% /c %POWERSHELL_EXE% -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
	
	:: get LAST_ARG
	for %%a in (%*) do set LAST_ARG=%%a
	
	:: get ALL_BUT_FIRST_ARGS
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
	
	:: call DKPowershell function
	for /f "delims=" %%Z in ('%POWERSHELL_EXE% -Command $global:DKSCRIPT_PATH ^= '%DKSCRIPT_PATH%'^; . %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1^; %~1 %ALL_BUT_FIRST_ARGS%') do (

		echo %%Z                &rem  Display the other shell's stdout
        set "rtn_value=%%Z"     &rem  Set the return value to the last line of output
	)

	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callDKPowershell dk_test "arg 1" "arg 2" rtn_var
    %dk_call% dk_echo
	%dk_call% dk_echo "rtn_var = %rtn_var%"
%endfunction%
