@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_decimalToVariable(<decimal> rtn_var)
::#
:dk_decimalToVariable
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	::setlocal
	call dk_decimalToHex %~2 hex
	call dk_hexToVariable %~1 %hex%
	::endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	set "myDecimal=32"
	call dk_decimalToVariable "%myDecimal%" myVariable
	call dk_printVar myVariable
goto:eof
