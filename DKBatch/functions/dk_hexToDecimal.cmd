@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_hexToDecimal(<hex_string> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToDecimal
    %dk_call% dk_debugFunc 2
 setlocal
 
    set "hex=%~1"
    set "decimal="
    set /A hexToDecimal=0x%hex:~-2%
    
    endlocal & set "%2=%hexToDecimal%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_hexToDecimal 0x1b decimal
    %dk_call% dk_echo "decimal = %decimal%"
%endfunction%
