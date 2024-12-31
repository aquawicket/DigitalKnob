@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_buildApp()
::#
::#
:dk_buildApp
    %dk_call% dk_debugFunc 0
 setlocal

    TITLE DigitalKnob - Building %target_app% - %target_triple% -%target_type% - %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_echo "###############################################################"
    %dk_call% dk_echo "****** Building %target_app% - %target_triple% - %target_type% - %DKLEVEL% ******"
    %dk_call% dk_echo "###############################################################"
    %dk_call% dk_echo

    %dk_call% dk_assertVar target_type
    if %target_type%==All         %dk_call% dk_buildAll
    if %target_type%==Release     %dk_call% dk_buildRelease
    if %target_type%==Debug       %dk_call% dk_buildDebug

    %dk_call% dk_echo
    %dk_call% dk_echo "####################################################################"
    %dk_call% dk_echo "****** Done Building %target_app% - %target_triple% - %target_type% - %DKLEVEL% ******"
    %dk_call% dk_echo "####################################################################"
    %dk_call% dk_echo
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal

    %dk_call% dk_buildApp
%endfunction%
