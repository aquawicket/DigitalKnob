::dk_includeGuard()

::#################################################################################
:: dk_endMessage()
::
::
:dk_endMessage
	call dk_verbose "%0(%*)"
	
    TITLE DigitalKnob - Done Building %APP%_%TARGET_OS%_%TYPE% %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
        
    set UPDATE=
    set APP=
    set TARGET_OS=
    set TYPE=
goto:eof