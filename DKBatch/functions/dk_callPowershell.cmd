@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_callPowershell(function, arguments..., return_args...)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callPowershell
    call dk_debugFunc 1 99
 setlocal
	
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_setPOWERSHELL_EXE"
    %dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	
	:: https://stackoverflow.com/a/4732316/688352
    call %ComSpec% /c %POWERSHELL_EXE% -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
	
	:: get last argument
	for %%a in (%*) do set LAST_ARG=%%a
	
	:: get all but fisrt argument
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST_ARGS=%%b
	
	for /f "delims=" %%Z in ('%POWERSHELL_EXE% -Command $global:DKSCRIPT_PATH ^= '%DKSCRIPT_PATH%'^; . %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1^; %~1 %ALL_BUT_FIRST_ARGS%') do (
		echo %%Z
		set "rtn_value=%%Z"
	)
	
::	for /f "delims=" %%Z in ('%POWERSHELL_EXE% -Command -noprofile "iex (${%~f0} | out-string)"') do (
::        ::endlocal & set %1=%%~Z
::    )
	
	if "%LAST_ARG%" == "rtn_var" endlocal & set "%LAST_ARG%=%rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callPowershell dk_test "parameter1" "parameter2" rtn_var
	echo rtn_var = %rtn_var%
	::%dk_call% dk_callPowershell dk_confirm
    ::%dk_call% dk_callPowershell dk_debug "string from DKBatch"

%endfunction%
