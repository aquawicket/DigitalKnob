@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


call dk_load dk_printVar
::################################################################################
::# dk_set(name, value)
::#
::#
:dk_set
	call dk_debugFunc 1 2
	
	set "%~1=%~2"
	call dk_printVar "%~1"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
	call dk_debugFunc 0
	
	call dk_set myVar "value assigned with dk_set"
	call dk_echo "myVar = %myVar%"
goto:eof
