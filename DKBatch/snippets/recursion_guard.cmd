<<<<<<< HEAD
@echo off
if not defined DKINIT if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# recursion_guard(commands)
::#
::#
:myFunction
	if defined myFunction (goto:eof) else (set "myFunction=1")   &::disallow recursion for this function
<<<<<<< HEAD
	call dk_debugFunc 0
	setlocal

		call myFunction
	
	endlocal
=======
	%dk_call% dk_debugFunc 0
setlocal

		call myFunction
	
endlocal
>>>>>>> Development
	set "myFunction="  &::function complete, remove recursion block
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
	call dk_debugFunc 0
=======
setlocal
	%dk_call% dk_debugFunc 0
>>>>>>> Development

	call myFunction
%endfunction%
