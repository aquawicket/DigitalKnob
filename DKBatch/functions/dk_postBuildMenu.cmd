@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    call dk_echo
    echo %APP% %TARGET_OS% %TYPE%
        
    call dk_echo
goto:eof