@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_buildApp()
::#
::#
:dk_buildApp
    call dk_debugFunc 0
 setlocal

    TITLE DigitalKnob - Building %APP% - %triple% -%TYPE% - %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_echo "###############################################################"
    %dk_call% dk_echo "****** Building %APP% - %triple% - %TYPE% - %DKLEVEL% ******"
    %dk_call% dk_echo "###############################################################"
    %dk_call% dk_echo

    %dk_call% dk_assert TYPE
    if %TYPE%==All      %dk_call% dk_buildAll
    if %TYPE%==Release  %dk_call% dk_buildRelease
    if %TYPE%==Debug    %dk_call% dk_buildDebug

    %dk_call% dk_echo
    %dk_call% dk_echo "####################################################################"
    %dk_call% dk_echo "****** Done Building %APP% - %triple% - %TYPE% - %DKLEVEL% ******"
    %dk_call% dk_echo "####################################################################"
    %dk_call% dk_echo
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_buildApp
%endfunction%
