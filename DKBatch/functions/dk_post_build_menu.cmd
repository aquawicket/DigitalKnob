::dk_include_guard()

::#################################################################################
:: dk_post_build_menu()
::
::
:dk_post_build_menu
	call dk_verbose "%0(%*)"
	
    TITLE DigitalKnob - %APP% %TARGET_OS% %TYPE%
    echo.
    echo %APP% %TARGET_OS% %TYPE%
        
    echo.
goto:eof