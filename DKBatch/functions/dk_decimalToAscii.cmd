@echo off
call DK

::####################################################################
::# dk_decimalToAscii(<decimal> <output>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToAscii () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_decimalToHex %~1 hex
	call dk_hexToAscii %hex% ascii
	
	endlocal & set %2=%ascii%
goto:eof




:DKTEST ###############################################################################

	set "myDecimal=123"
	call dk_decimalToAscii "%myDecimal%" myAscii
	call dk_printVar myAscii