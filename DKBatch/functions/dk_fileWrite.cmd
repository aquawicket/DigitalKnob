@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_fileWrite(file, string)
::#
::#
:dk_fileWrite
setlocal
	%dk_call% dk_debugFunc 2

    echo %~2 > "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
    %dk_call% dk_fileWrite "%DKCACHE_DIR%/dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
%endfunction%
