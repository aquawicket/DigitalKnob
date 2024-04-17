::dk_include_guard()

::####################################################################
::# dk_validate_make()
::#
::#
:dk_validate_make () {
	call:dk_verbose "dk_validate_make(%*)"
	
    call:dk_cmake_eval "include('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
    call:dk_check_error
goto:eof