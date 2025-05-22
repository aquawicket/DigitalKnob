@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# recursion_guard(commands)
::#
::#
:myFunction
	if defined myFunction (goto:eof) else (set "myFunction=1")   &::disallow recursion for this function
	%dk_call% dk_debugFunc 0
setlocal

		call myFunction
	
endlocal
	set "myFunction="  &::function complete, remove recursion block
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	call myFunction
%endfunction%
