@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_asciiToDecimal(ascii, rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal
 setlocal
	call dk_debugFunc 2
	
	setlocal
	%dk_call% dk_asciiToHex %~1 hex
	%dk_call% dk_hexToDecimal %hex% decimal
	endlocal & set "%2=%decimal%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_set myAscii x
	%dk_call% dk_asciiToDecimal myAscii myDecimal
	%dk_call% dk_info "myDecimal = %myDecimal%"
%endfunction%
