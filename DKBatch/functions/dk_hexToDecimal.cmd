@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_hexToDecimal(<hex_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal () {
	call dk_debugFunc
	
	set "hex=%~1"
	set "decimal="
	set /A decimal=0x%hex:~-2%
	
	::echo     dk_hexToDecimal %hex% = %decimal%
	endlocal & set %2=%decimal%
goto:eof

