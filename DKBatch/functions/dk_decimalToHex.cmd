@echo OFF
::dk_includeGuard()

::####################################################################
::# dk_decimalToHex(<decimal_string>)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToHex () {
	::call dk_verbose "dk_decimalToHex(%*)"
	
	cmd /C exit %~1
	set "hex=%=ExitCode%"
	set "hex=0x%hex:~-2%"
	
	::echo     dk_decimalToHex %~1 = %hex%
	endlocal & set %2=%hex%
goto:eof


