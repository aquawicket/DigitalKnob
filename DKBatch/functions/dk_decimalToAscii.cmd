@echo off
call DK

::####################################################################
::# dk_decimalToAscii(<decimal> <output>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToAscii () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	call dk_decimalToHex %~1 hex
	call dk_hexToAscii %hex% ascii
	
	endlocal & set %2=%ascii%
goto:eof


:DKTEST ###############################################################################

	set "myDecimal=123"
	call dk_decimalToAscii "%myDecimal%" myAscii
	call dk_printVar myAscii