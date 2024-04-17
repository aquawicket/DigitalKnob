::dk_include_guard()

::################################################################################
::# dk_delete_temp_files()
::#
::#
:dk_delete_temp_files () {
	call dk_verbose "dk_delete_temp_files(%*)"
	
    ::call dk_cmake_eval "dk_deleteTempFiles()"
    echo Deleteing .tmp files . . .
    cd "%DIGITALKNOB_DIR%"
    for /r %%i in (*.tmp) do del "%%i"
    for /r %%i in (*.TMP) do del "%%i"
    call dk_check_error
goto:eof