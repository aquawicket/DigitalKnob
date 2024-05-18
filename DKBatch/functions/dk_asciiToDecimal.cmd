@echo off
call DK

::####################################################################
::# dk_asciiToDecimal(<ascii> <output>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_asciiToHex %~1 hex
	call dk_hexToDecimal %hex% decimal
	
	endlocal & set "%2=%decimal%"
	call dk_printVar "%2"
goto:eof



:DKTEST ########################################################################
	
	set "myAscii=x"
	call dk_asciiToDecimal myAscii myDecimal
	echo myDecimal = %myDecimal%
