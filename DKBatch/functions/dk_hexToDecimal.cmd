@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_hexToDecimal(<hex_string> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "hex=%~1"
	set "decimal="
	set /A hexToDecimal=0x%hex:~-2%
	
	endlocal & set "%2=%hexToDecimal%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_hexToDecimal 0x1b decimal
	call dk_echo "decimal = %decimal%"
goto:eof
