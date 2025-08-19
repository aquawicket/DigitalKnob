@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_appendEvnPath(path)
::#
::#   Func: Appends a path to the %PATH% environment variable
::#   path: A string containing the new path
::#
::#	Example:  %dk_call% dk_appendEvnPath C:/Windows/System32 result
::#			  echo dk_appendEvnPath returned: %result%
::#
:dk_appendEvnPath
%setlocal%
	%dk_call% dk_debugFunc 1

	::###### input ######
	set "_path_=%~1"


	%dk_call% dk_contains "%PATH%" "%_path_:/=\%;" && (
		%dk_call% dk_info "environment PATH already contains _path_:%_path_%"
		%return%
	)

	::###### output ######
	endlocal & (
		set "PATH=%PATH%;%_path_:/=\%"
	)
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	::%dk_call% dk_appendEvnPath "%DKBATCH_FUNCTIONS_DIR%"

	%dk_call% dk_appendEvnPath "%USERPROFILE:\=/%/DigitalKnob/Development/DKCMake"
	echo %PATH%
%endfunction%
