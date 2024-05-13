@echo off
call DK

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
    TITLE DigitalKnob - Done Building %APP%_%TARGET_OS%_%TYPE% %DKLEVEL% . . .
    call dk_echo
    call dk_info "####################################################################"
	call dk_info "****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******"
    call dk_info "####################################################################"
    call dk_echo
        
    set "UPDATE="
    set "APP="
    set "TARGET_OS="
    set "TYPE="
goto:eof




:DKTEST ########################################################################
