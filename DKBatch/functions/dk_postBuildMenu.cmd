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
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setTitle DigitalKnob - %APP% %triple% %TYPE%
    %dk_call% dk_echo
    echo %APP% %triple% %TYPE%
=======
setlocal
    %dk_call% dk_debugFunc 0
    
    %dk_call% dk_echo
    echo %target_app% %target_triple% %target_type%
>>>>>>> Development
        
    %dk_call% dk_echo
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
    %dk_call% dk_postBuildMenu
%endfunction%
