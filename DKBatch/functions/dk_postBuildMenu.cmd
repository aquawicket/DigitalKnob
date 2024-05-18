@echo off
call DK

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
        
    echo.
goto:eof