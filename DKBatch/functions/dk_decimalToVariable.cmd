@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_decimalToVariable(<decimal> rtn_var)
::#
:dk_decimalToVariable
	call dk_debugFunc 2
	
	::setlocal
	%dk_call% dk_decimalToHex %~2 hex
	%dk_call% dk_hexToVariable %~1 %hex%
	::endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	set "myDecimal=32"
	%dk_call% dk_decimalToVariable "%myDecimal%" myVariable
	%dk_call% dk_printVar myVariable
goto:eof
