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
::# dk_keepConsoleOpen()
::#
::#
:dk_keepConsoleOpen
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 0
    
=======
setlocal
    %dk_call% dk_debugFunc 0
    
	
>>>>>>> Development
    if not defined in_subprocess (%ComSpec% /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
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
    %dk_call% dk_keepConsoleOpen
%endfunction%
