@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_mkdir(path)
::#
::#
:dk_mkdir
setlocal
    %dk_call% dk_debugFunc 1

	set "_path_=%~1"
    if exist "%_path_%" (
		%dk_call% dk_warning "%_path_% already exists"
		%return%
	)
	
    mkdir "%_path_:/=\%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_mkdir "CreatedDirectory"
%endfunction%
