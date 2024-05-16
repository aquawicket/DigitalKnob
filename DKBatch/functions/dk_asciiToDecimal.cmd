@echo off
call DK

::####################################################################
::# dk_asciiToDecimal(<ascii> <output>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_asciiToHex %~1 hex
	call dk_hexToDecimal %hex% decimal
	
	endlocal & set "%2=%decimal%"
goto:eof



:DKTEST ########################################################################
	
	set "myAscii=x"
	call dk_asciiToDecimal myAscii myDecimal
	call dk_printVar myDecimal
