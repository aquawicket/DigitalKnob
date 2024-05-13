@echo off
call DK

::####################################################################
::# dk_deleteCache()
::#
::#
:dk_deleteCache () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
    call dk_info "Deleteing CMake cache files. . ."
	
	call dk_validate DIGITALKNOB_DIR dk_getDKPaths
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call dk_checkError
goto:eof



:DKTEST ########################################################################
