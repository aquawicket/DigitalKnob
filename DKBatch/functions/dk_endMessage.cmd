@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_setTitle
::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_setTitle Done Building %APP%_%TARGET_OS%_%TYPE% %DKLEVEL% . . .
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




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_endMessage
goto:eof
