@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#####################################################################
::# dk_build()
::#
::#
:dk_build
	call dk_debugFunc 0
	
    TITLE DigitalKnob - Building %APP% - %TARGET_OS% -%TYPE% - %DKLEVEL% . . .
    call dk_echo
    call dk_echo "###############################################################"        
    call dk_echo "****** Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******"
    call dk_echo "###############################################################"
    call dk_echo
	
	if %TYPE%==All      call dk_buildAll
	if %TYPE%==Release  call dk_buildRelease
	if %TYPE%==Debug    call dk_buildDebug
	
	call dk_echo
    call dk_echo "####################################################################"     
    call dk_echo "****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******"
    call dk_echo "####################################################################"
    call dk_echo
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_build
goto:eof
