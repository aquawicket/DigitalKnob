@echo OFF
::dk_includeGuard()

::####################################################################
::# dk_hexToDecimal(<hex_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal () {
	::call dk_verbose "dk_hexToDecimal(%*)"
	
	set "hex=%~1"
	set /A decimal=0x%hex:~-2,2%
	
	echo     dk_hexToDecimal %hex% = %decimal%
	endlocal & set %2=%decimal%
goto:eof


