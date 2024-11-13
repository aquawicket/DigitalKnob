@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)" 

::####################################################################
::# dk_isDelayedExpansion(rtn_var)
::#
::#
:dk_isDelayedExpansion
    call dk_debugFunc 1
 setlocal
 
    if "!DE!" == "" (
      set "%1=ON"
    )  else (
      set "%1=OFF"
    )
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

    
    %dk_call% dk_isDelayedExpansion deylayedExpansion
    echo deylayedExpansion = %deylayedExpansion%
%endfunction%