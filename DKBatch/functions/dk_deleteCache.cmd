::dk_include_guard()

::####################################################################
::# dk_deleteCache()
::#
::#
:dk_deleteCache () {
	call dk_verbose "dk_deleteCache(%*)"
	
    ::call dk_cmake_eval "dk_deleteCache()"
    echo Deleteing CMake cache . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call dk_check_error
goto:eof