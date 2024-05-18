@echo off
call DK

::####################################################################
::# dk_clearCmakeCache()
::#
::#
:dk_clearCmakeCache () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    call dk_info "Deleteing CMake cache files. . ."
	
	call dk_validate DIGITALKNOB_DIR dk_getDKPaths
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call dk_checkError
goto:eof



:DKTEST ########################################################################
