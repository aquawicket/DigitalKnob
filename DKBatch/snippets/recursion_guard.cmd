@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# recursion_guard(commands)
::#
::#
:myFunction
	if defined myFunction (goto:eof) else (set "myFunction=1")   &::disallow recursion for this function
	call dk_debugFunc 0
	setlocal

		call myFunction
	
	endlocal
	set "myFunction="  &::function complete, remove recursion block
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call myFunction
goto:eof