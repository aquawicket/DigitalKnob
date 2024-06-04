@echo off
call DK

::################################################################################
::# dk_decimalToVariable(<decimal> <output>)
::#
:dk_decimalToVariable () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_decimalToHex %~2 hex
	call dk_hexToVariable %~1 %hex%
goto:eof


:DKTEST ###############################################################################

	set "myDecimal=32"
	call dk_decimalToVariable "%myDecimal%" myVariable
	call dk_printVar myVariable
	