::dk_includeGuard()

::####################################################################
::# dk_deleteCache()
::#
::#
:dk_deleteCache () {
	call dk_verbose "dk_deleteCache(%*)"
	
    ::call dk_cmakeEval "dk_deleteCache()"
    echo Deleteing CMake cache . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (CMakeCache.*) do del "%%i"
    for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i"
    call dk_checkError
goto:eof