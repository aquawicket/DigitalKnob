@echo off
call DK


::####################################################################
::# dk_createFunctionList()
::#
::#
:dk_createFunctionList() {
    :: create a list of all dk_functions
	call dk_validate DKBATCH_FUNCTIONS_DIR "call dk_validateBranch"
    call dk_remove _functionList_
    setlocal enableDelayedExpansion
	for %%a in (%DKBATCH_FUNCTIONS_DIR%\*) do (
        set "_func_=%%~na"
        set "_match_=!_func_:dk_=!"
        if not !_match_!==%%~na (
			rem echo %%~na
            echo %%~na >> %DKBATCH_FUNCTIONS_DIR%\_functionList_
        )			
    )
goto:eof




:DKTEST ########################################################################

	call dk_createFunctionList