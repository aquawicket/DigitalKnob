@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_setTitle Done Building %APP%_%TARGET_OS%_%TYPE% %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
	%dk_call% dk_info "****** Done Building %APP% - %TARGET_OS% - %TYPE% - %DKLEVEL% ******"
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_echo
        
    set "UPDATE="
    set "APP="
    set "TARGET_OS="
    set "TYPE="
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_endMessage
goto:eof
