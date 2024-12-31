@echo off
if not defined DKINIT if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

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
	%dk_call% dk_debugFunc 0

	call myFunction
%endfunction%
