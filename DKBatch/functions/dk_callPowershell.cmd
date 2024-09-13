@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_callPowershell(function, arguments..., return_args...)
::#
::#
:dk_callPowershell
    call dk_debugFunc 1 99
 setlocal
	
    %dk_call% dk_validate DKPOWERSHELL_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	
	:: https://stackoverflow.com/a/4732316/688352
    call %ComSpec% /c powershell Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
	
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b
	echo ALL_BUT_FIRST = %ALL_BUT_FIRST%
	
	echo 'powershell . %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1^; %~1 %ALL_BUT_FIRST%'
	for /f "delims=" %%Z in ('powershell . %DKPOWERSHELL_FUNCTIONS_DIR%\%~1.ps1^; %~1 %ALL_BUT_FIRST%') do (
		echo %%Z
		set "rtn_value=%%Z"
	)
	echo "rtn_value = %rtn_value%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_callPowershell dk_test "parameter1" "parameter2"
	::%dk_call% dk_callPowershell dk_confirm
    ::%dk_call% dk_callPowershell dk_debug "string from DKBatch"

%endfunction%
