@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_fileAppend(file, string)
::#
::#
:dk_fileAppend
setlocal
	%dk_call% dk_debugFunc 2
	set "_file_=%~1"
	set "_file_=%_file_:/=\%
	
    if exist "%_file_%" (
        echo %~2 >> "%_file_%"
    ) else (
        echo %~2 > "%_file_%"
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
%endfunction%
