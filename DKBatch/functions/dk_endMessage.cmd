@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_title Done Building %target_app%_%target_triple%_%target_type% %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_info "****** Done Building %target_app% - %target_triple% - %target_type% - %DKLEVEL% ******"
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_echo
        
    set "UPDATE="
    set "target_app="
    set "target_triple="
    set "target_type="
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_endMessage
%endfunction%
