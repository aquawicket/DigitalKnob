@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#####################################################################
::# dk_buildApp()
::#
::#
:dk_buildApp
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
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_buildApp
goto:eof