@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_asciiToDecimal(ascii)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToDecimal
setlocal
	%dk_call% dk_debugFunc 1

    %dk_call% dk_asciiToHex %~1
    %dk_call% dk_hexToDecimal %dk_asciiToHex%
    endlocal & set "dk_asciiToDecimal=%dk_hexToDecimal%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myAscii x
    %dk_call% dk_asciiToDecimal myAscii
    %dk_call% dk_info "dk_asciiToDecimal = %dk_asciiToDecimal%"
%endfunction%
