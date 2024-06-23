@echo off
call DK.cmd

::#####################################################################
::# dk_build()
::#
::#
:dk_build () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
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



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_build
goto:eof