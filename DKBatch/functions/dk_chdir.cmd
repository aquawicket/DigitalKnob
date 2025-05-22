@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_chdir(directory)
::#
::#
:dk_chdir
%setlocal%
	%dk_call% dk_debugFunc 0 1

	set "_directory_=%~1"
	title %_directory_%
	endlocal & cd "%_directory_:/=\%"
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo "Current Directory = %CD%"
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_chdir "%DKBRANCH_DIR%"
	%dk_call% dk_echo "Current Directory = %CD%"
%endfunction%
