@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_unset(name)
::#
::#
:dk_unset
    call dk_debugFunc 1
:: setlocal
   
    set "%~1="
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myVar "initial value assigned with dk_unset"
    echo myVar = %myVar%
    %dk_call% dk_unset myVar
    echo myVar = %myVar%
%endfunction%
