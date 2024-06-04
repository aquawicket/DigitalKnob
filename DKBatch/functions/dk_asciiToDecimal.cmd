@echo off
call DK

::####################################################################
::# dk_asciiToDecimal(<ascii> <rtn_var>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_asciiToHex %~1 hex
	call dk_hexToDecimal %hex% decimal
	endlocal & call dk_set %2 "%decimal%"
goto:eof



:DKTEST ########################################################################
	
	call dk_set myAscii x
	call dk_asciiToDecimal myAscii myDecimal
	echo myDecimal = %myDecimal%
