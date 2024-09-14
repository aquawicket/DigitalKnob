@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_replaceAll(input searchValue newValue trn_var)
::#
::#
:dk_replaceAll
 setlocal
    call dk_debugFunc 4
    
    setlocal
    set "_input_=%~1"
    if "!DE!" equ "" set "_output_=!_input_:%~2=%~3!"
    if "!DE!" neq "" call set "_output_=%%_input_:%~2=%~3%%"
    
    endlocal & set "%4=%_output_%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ########
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_set string_var "AZC AZC Zannana Zread"
    %dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "Z" "B" string_var
    %dk_call% dk_printVar string_var

    %dk_call% dk_set varB "C:\path\with\backslashes"
    %dk_call% dk_printVar varB
    %dk_call% dk_replaceAll "%varB%" "\" "/" varB
    %dk_call% dk_printVar varB
%endfunction%
