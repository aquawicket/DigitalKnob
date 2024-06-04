@echo off
call DK

::################################################################################
::# dk_unset(<name>)
::#
::#
:dk_unset () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "%~1="
goto:eof



:DKTEST ########################################################################

	set "myVar=initial value assigned with dk_unset"
	echo myVar = %myVar%
	call dk_unset myVar
	echo myVar = %myVar%
