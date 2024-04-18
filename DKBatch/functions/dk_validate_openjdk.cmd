::dk_include_guard()

::####################################################################
::# dk_validate_openjdk()
::#
::#
:dk_validate_openjdk () {
	call dk_verbose "dk_validate_openjdk(%*)"
	
    call dk_cmake_eval "dk_load('%DKIMPORTS_DIR%/openjdk/DKMAKE.cmake')" "OPENJDK"
	call dk_debug OPENJDK
    call dk_check_error
goto:eof