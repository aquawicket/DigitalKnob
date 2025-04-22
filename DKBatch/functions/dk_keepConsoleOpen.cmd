@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################################################################################
::# dk_keepConsoleOpen()
::#
::#
:dk_keepConsoleOpen
setlocal
    %dk_call% dk_debugFunc 0
    
	
    if not defined in_subprocess (%COMSPEC% /k set in_subprocess=y ^& %DKSCRIPT_PATH%) & exit ) :: keep window open
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
   
    %dk_call% dk_keepConsoleOpen
%endfunction%
