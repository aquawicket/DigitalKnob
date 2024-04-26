call dk_includeGuard

::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
	call dk_debugFunc
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
        
    echo.
goto:eof