::dk_include_guard()

::#################################################################################
:: dk_postBuildMenu()
::
::
:dk_postBuildMenu
	call dk_verbose "%0(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
        
    echo.
goto:eof