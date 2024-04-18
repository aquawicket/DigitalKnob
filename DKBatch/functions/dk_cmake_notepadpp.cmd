::dk_include_guard()

::####################################################################
::# dk_cmake_notepadpp()
::#
::#
:dk_cmake_notepadpp () {
	call dk_verbose "dk_cmake_notepadpp(%*)"
	
	if "%DKIMPORTS_DIR%"==""  call dk_validate_branch
    call dk_cmake_eval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')"
    call dk_check_error
goto:eof