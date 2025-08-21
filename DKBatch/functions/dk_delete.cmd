@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# dk_delete(path)
::#
::#
:dk_delete
%setlocal%
	%dk_call% dk_debugFunc 1
	
	set "_path_=%~1"
	
	%dk_call% dk_realpath "%_path_%"
	
    if NOT EXIST "%dk_realpath%" (
        %dk_call% dk_warning "dk_delete dk_realpath:%dk_realpath% does NOT EXIST"
        %return%
    )

    del /F /Q "%_path_:/=\%" %NO_OUTPUT%
    rd /s /q "%_path_:/=\%" %NO_OUTPUT%

    if EXIST "%_path_%" (
        %dk_call% dk_error "dk_delete failed to remove _path_:%_path_%"
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_fileWrite "removeMe.file" "created file to test dk_delete"
    %dk_call% dk_delete "removeMe.file"
%endfunction%
