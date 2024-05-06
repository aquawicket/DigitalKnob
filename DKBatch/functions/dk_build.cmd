@echo off
call DK

::#####################################################################
::# dk_build()
::#
::#
:dk_build () {
	call dk_debugFunc
	
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
	
	if %TYPE%==All      call dk_buildAll
	if %TYPE%==Release  call dk_buildRelease
	if %TYPE%==Debug    call dk_buildDebug
	
	echo.
    echo ###########################################################        
    echo ****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
goto:eof