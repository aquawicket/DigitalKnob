@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_decimalToHex(<decimal> hex)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_decimalToHex
 setlocal
    call dk_debugFunc 2
    
    set "_LOOKUP_=0123456789abcdef"
    set "_hex_="
    set "_prefix_="
    if "%~1"=="" set "_hex_=00" & goto :endlookup
    set /a A=%~1
    if %A% lss 0 set /a A=0xfffffff + %A% + 1 & set "_prefix_=f"
    :loop
        set /a B=%A% %% 16 & set /a A=%A% / 16
        
        if "!DE!" equ "" set "_hex_=!_LOOKUP_:~%B%,1!%_hex_%"
        if "!DE!" neq "" call set "_hex_=%%_LOOKUP_:~%B%,1%%%_hex_%"
        
        if %A% gtr 0 goto :loop
    :endlookup
    endlocal & set "%2=0x%_prefix_%%_hex_%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_set myDecimal 45
    %dk_call% dk_decimalToHex "%myDecimal%" myHex
    %dk_call% dk_printVar myHex
%endfunction%
