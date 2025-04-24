@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_removeExtension(filepath rtn_var)
::#
::#
:dk_removeExtension
setlocal
    %dk_call% dk_debugFunc 1 2
    
    set "_filepath_=%~1"
    %dk_call% dk_getExtension "%_filepath_%"
    %dk_call% dk_replaceAll "%_filepath_%" "%dk_getExtension%" ""
    
    endlocal & (
		set "dk_removeExtension=%dk_replaceAll%"
		if "%~2" neq "" (set "%~2=%dk_replaceAll%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_set myPath "/test/test2/xfile.extension"
    %dk_call% dk_removeExtension "%myPath%"
    %dk_call% dk_printVar dk_removeExtension
%endfunction%
