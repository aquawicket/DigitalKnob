@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_info "****** Done Building %target_app% - %target_triple% - %target_type% - %target_level% ******"
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_echo
        
    set "UPDATE="
    set "target_app="
    set "target_triple="
    set "target_type="
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_endMessage
%endfunction%
