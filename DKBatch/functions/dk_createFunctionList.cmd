@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::####################################################################
::# dk_createFunctionList()
::#
::#
:dk_createFunctionList
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
    :: create a list of all dk_functions and store them in _functionList_
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	if not exist "%DKBRANCH_DIR%\.git" (goto:eof)    &:: only create functions list when we have a local repository
	
    call dk_remove "%DKBATCH_FUNCTIONS_DIR_%_functionList_"
	for %%a in (%DKBATCH_FUNCTIONS_DIR_%dk_*.cmd) do (
		echo %%~na
		call dkFileAppend "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %%~na
    )
	
	if not exist "%DKBATCH_FUNCTIONS_DIR_%_functionList_" call dk_error "_functionList_ is missing")
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_createFunctionList
goto:eof
