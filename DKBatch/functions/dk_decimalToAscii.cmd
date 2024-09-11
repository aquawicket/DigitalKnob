@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_decimalToAscii(<decimal> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToAscii
    call dk_debugFunc 2
 setlocal
 
    setlocal
    %dk_call% dk_decimalToHex %~1 hex
    %dk_call% dk_hexToAscii %hex% ascii
    
    endlocal & set "%2=%ascii%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myDecimal 123
    %dk_call% dk_decimalToAscii "%myDecimal%" myAscii
    %dk_call% dk_printVar myAscii
%endfunction%
