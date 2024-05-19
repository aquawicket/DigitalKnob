@echo off
call DK

::################################################################################
::# dk_exit()
::#
::#
:dk_exit () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	::cmd /k & exit
	exit
goto:eof




:DKTEST ########################################################################
