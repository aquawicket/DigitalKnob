@echo off
call DK

::################################################################################
::# dk_decimalToVariable(<decimal> <output>)
::#
:dk_decimalToVariable () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	call dk_decimalToHex %~2 hex
	call dk_hexToVariable %~1 %hex%
goto:eof


:DKTEST ###############################################################################

	set "myDecimal=32"
	call dk_decimalToVariable "%myDecimal%" myVariable
	call dk_printVar myVariable
	