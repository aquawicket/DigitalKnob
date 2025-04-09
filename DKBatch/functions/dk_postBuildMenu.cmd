@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
setlocal
    %dk_call% dk_debugFunc 0
    
    %dk_call% dk_echo
    echo %target_app% %target_triple% %target_type%
        
    %dk_call% dk_echo
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_postBuildMenu
%endfunction%
