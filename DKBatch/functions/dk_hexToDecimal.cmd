@echo off
call DK

::####################################################################
::# dk_hexToDecimal(<hex_string> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "hex=%~1"
	set "decimal="
	set /A decimal=0x%hex:~-2%
	
	endlocal & call dk_set %2 "%decimal%"
goto:eof


