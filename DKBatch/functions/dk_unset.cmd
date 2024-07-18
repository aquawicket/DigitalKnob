@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_unset(name)
::#
::#
:dk_unset
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "%~1="
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myVar "initial value assigned with dk_unset"
	echo myVar = %myVar%
	call dk_unset myVar
	echo myVar = %myVar%
goto:eof
