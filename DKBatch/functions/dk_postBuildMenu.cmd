@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#################################################################################
::# dk_postBuildMenu()
::#
::#
:dk_postBuildMenu
%setlocal%
    %dk_call% dk_debugFunc 0
   
    %dk_call% dk_echo
    echo %Target_App% %Target_Tuple% %Target_Type%
       
    %dk_call% dk_echo
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
    %dk_call% dk_postBuildMenu
%endfunction%
