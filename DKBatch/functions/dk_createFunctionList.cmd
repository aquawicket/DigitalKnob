@echo off
call DK


::####################################################################
::# dk_createFunctionList()
::#
::#
:dk_createFunctionList() {
    :: create a list of all dk_functions and store them in _functionList_
	call dk_validate DKBATCH_FUNCTIONS_DIR "call dk_validateBranch"
    call dk_remove _functionList_
	for %%a in (%DKBATCH_FUNCTIONS_DIR%\dk_*.cmd) do (
		rem echo %%~na
        echo %%~na >> %DKBATCH_FUNCTIONS_DIR%\_functionList_
    )
	
	if not exist %DKBATCH_FUNCTIONS_DIR%\_functionList_ (call dk_error "_functionList_ is missing")
goto:eof




:DKTEST ########################################################################

	call dk_createFunctionList