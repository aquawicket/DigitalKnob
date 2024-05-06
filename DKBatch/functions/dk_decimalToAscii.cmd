@echo off
call DK

::####################################################################
::# dk_decimalToAscii(<decimal_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToAscii () {
	call dk_debugFunc
	
	call dk_decimalToHex %~1 hex
	call dk_hexToAscii %hex% ascii
	
	::echo     dk_decimalToAscii %~1 = %ascii%
	endlocal & set %2=%ascii%
goto:eof


