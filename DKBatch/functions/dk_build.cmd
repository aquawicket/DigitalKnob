::dk_include_guard()

::#####################################################################
::# dk_build()
::#
::#
:dk_build () {
	call:dk_verbose "dk_build(%*)"
	
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    echo.
    echo ###########################################################        
    echo ****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
	
	if %TYPE%==All      call:dk_build_all
	if %TYPE%==Release  call:dk_build_release
	if %TYPE%==Debug    call:dk_build_debug
	
	echo.
    echo ###########################################################        
    echo ****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******
    echo ###########################################################
    echo.
goto:eof