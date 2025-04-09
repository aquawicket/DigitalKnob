@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)" 

::####################################################################
::# dk_isDelayedExpansion(rtn_var)
::#
::#
:dk_isDelayedExpansion
setlocal
	%dk_call% dk_debugFunc 1
    if "!DE!" == "" (
      set "%1=ON"
    )  else (
      set "%1=OFF"
    )
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    
    %dk_call% dk_isDelayedExpansion deylayedExpansion
    echo deylayedExpansion = %deylayedExpansion%
%endfunction%