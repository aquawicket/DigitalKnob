@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
	call dk_debugFunc 0
	
    %dk_call% dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    %dk_call% dk_echo
    echo %APP% %TARGET_OS% %TYPE%
        
    %dk_call% dk_echo
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_postBuildMenu
goto:eof
