@echo off
::if defined include_guard_dk_load ( goto:eof ) else set include_guard_dk_load=1
call DK


::####################################################################
::# dk_loadAll()
::#
::#
:dk_loadAll() {
    :: create a list of all dk_ functions
    del _functionList_
    setlocal enableDelayedExpansion
    for %%a in (*) do (
        set "_func_=%%~na"
        set "_match_=!_func_:dk_=!"
        if not !_match_!==%%~na (
            echo %%~na >> _functionList_
            echo %%~na
        )			
    )		 
goto:eof




:DKTEST ########################################################################

	call dk_loadAll