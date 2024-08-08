@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_hexToDecimal(<hex_string> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal
	call dk_debugFunc 2
	
	set "hex=%~1"
	set "decimal="
	set /A hexToDecimal=0x%hex:~-2%
	
	endlocal & set "%2=%hexToDecimal%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call dk_hexToDecimal 0x1b decimal
	call dk_echo "decimal = %decimal%"
goto:eof
