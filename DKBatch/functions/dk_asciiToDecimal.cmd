@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_asciiToDecimal(ascii, rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	call dk_asciiToHex %~1 hex
	call dk_hexToDecimal %hex% decimal
	endlocal & set "%2=%decimal%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myAscii x
	call dk_asciiToDecimal myAscii myDecimal
	call dk_info "myDecimal = %myDecimal%"
goto:eof
