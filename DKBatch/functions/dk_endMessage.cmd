@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setTitle Done Building %APP%_%triple%_%DKBUILD_TYPE% %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_info "****** Done Building %APP% - %triple% - %DKBUILD_TYPE% - %DKLEVEL% ******"
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_echo
        
    set "UPDATE="
    set "APP="
    set "triple="
    set "DKBUILD_TYPE="
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_endMessage
%endfunction%
