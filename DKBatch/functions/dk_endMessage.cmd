@echo off
call dk_includeGuard
call DK

::#################################################################################
:: dk_endMessage()
::
::
:dk_endMessage
	call dk_debugFunc
	
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