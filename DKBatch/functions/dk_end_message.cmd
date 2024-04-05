::dk_include_guard()

::#################################################################################
:: dk_end_message()
::
::
:dk_end_message
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