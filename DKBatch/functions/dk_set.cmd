@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_set(name, value)
::#
::#
:dk_set
 setlocal
	call dk_debugFunc 1 2
	
	set "%~1=%~2"
	%dk_call% dk_printVar "%~1"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_set myVar "value assigned with dk_set"
	%dk_call% dk_echo "myVar = %myVar%"
goto:eof
