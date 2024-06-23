@echo off
call DK.cmd

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
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




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
