@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::#####################################################################
::# dk_buildApp()
::#
::#
:dk_buildApp
 setlocal
    call dk_debugFunc 0
    
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_echo "###############################################################"        
    %dk_call% dk_echo "****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******"
    %dk_call% dk_echo "###############################################################"
    %dk_call% dk_echo
    
    if %TYPE%==All      %dk_call% dk_buildAll
    if %TYPE%==Release  %dk_call% dk_buildRelease
    if %TYPE%==Debug    %dk_call% dk_buildDebug
    
    %dk_call% dk_echo
    %dk_call% dk_echo "####################################################################"     
    %dk_call% dk_echo "****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******"
    %dk_call% dk_echo "####################################################################"
    %dk_call% dk_echo
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_buildApp
%endfunction%
