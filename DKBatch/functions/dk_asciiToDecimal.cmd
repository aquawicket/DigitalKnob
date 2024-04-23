@echo OFF
::dk_includeGuard()

::####################################################################
::# dk_asciiToDecimal(<ascii_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal () {
	::call dk_verbose "dk_asciiToDecimal(%*)"
	
	call dk_asciiToHex %~1 hex
	call dk_hexToDecimal %hex% decimal
	
	echo     dk_asciiToDecimal %~1 = %decimal%
	endlocal & set %2=%decimal%
goto:eof


