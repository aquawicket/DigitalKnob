@echo off
call DK

::####################################################################
::# dk_asciiToDecimal(<ascii> <output>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	call dk_asciiToHex %~1 hex
	call dk_hexToDecimal %hex% decimal
	
	endlocal & set "%2=%decimal%"
goto:eof



:DKTEST ########################################################################
	
	set "myAscii=x"
	call dk_asciiToDecimal myAscii myDecimal
	call dk_printVar myDecimal
