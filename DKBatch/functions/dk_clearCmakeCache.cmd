@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_clearCmakeCache()
::#
::#
:dk_clearCmakeCache
	call dk_debugFunc 0
	
	setlocal
    call dk_info "Deleteing CMake cache files. . ."
	
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
	endlocal
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_clearCmakeCache
goto:eof
