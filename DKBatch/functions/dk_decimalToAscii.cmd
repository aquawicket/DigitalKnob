@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_decimalToAscii(<decimal> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToAscii
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	call dk_decimalToHex %~1 hex
	call dk_hexToAscii %hex% ascii
	
	endlocal & set "%2=%ascii%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myDecimal 123
	call dk_decimalToAscii "%myDecimal%" myAscii
	call dk_printVar myAscii
goto:eof
