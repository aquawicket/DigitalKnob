<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::#################################################################################
::# dk_endMessage()
::#
:dk_endMessage
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_setTitle Done Building %APP%_%triple%_%TYPE% %DKLEVEL% . . .
    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_info "****** Done Building %APP% - %triple% - %TYPE% - %DKLEVEL% ******"
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_info "****** Done Building %target_app% - %target_triple% - %target_type% - %target_level% ******"
>>>>>>> Development
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_echo
        
    set "UPDATE="
<<<<<<< HEAD
    set "APP="
    set "triple="
    set "TYPE="
=======
    set "target_app="
    set "target_triple="
    set "target_type="
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    %dk_call% dk_endMessage
%endfunction%
