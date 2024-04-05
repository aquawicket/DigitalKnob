::dk_include_guard()

::#################################################################################
:: dk_build()
::
::
:dk_build
	call dk_verbose "dk_build(%*)"
	
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
goto:eof