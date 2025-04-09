@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::####################################################################
::# dk_createFunctionList()
::#
::#
:dk_createFunctionList
setlocal
	%dk_call% dk_debugFunc 0

    :: create a list of all dk_functions and store them in _functionList_
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    if not exist "%DKBRANCH_DIR%\.git" (goto:eof)    &:: only create functions list when we have a local repository
    
    %dk_call% dk_delete "%DKBATCH_FUNCTIONS_DIR_%_functionList_"
    for %%a in (%DKBATCH_FUNCTIONS_DIR_%dk_*.cmd) do (
        echo %%~na
        %dk_call% dkFileAppend "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %%~na
    )
    
    if not exist "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %dk_call% dk_error "_functionList_ is missing")
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_createFunctionList
%endfunction%
