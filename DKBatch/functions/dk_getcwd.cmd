@echo off&::###### DK.cmd #########################################################################################################################
if not defined PWD (set "PWD=%CD:\=/%")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################



::##################################################################################
::# dk_getcwd()
::#
::#
:dk_getcwd
	%dk_call% dk_debugFunc 0
	
	endlocal & (
		set "dk_getcwd=%PWD%"
	)
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_call dk_getcwd
	%dk_call% dk_call dk_echo "dk_getcwd = '%dk_getcwd%'"
%endfunction%
