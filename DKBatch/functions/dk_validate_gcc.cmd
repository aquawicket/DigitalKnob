::dk_include_guard()

::####################################################################
::# dk_validate_gcc()
::#
::#
:dk_validate_gcc () {
	call:dk_verbose "dk_validate_gcc(%*)"
	
    call:dk_cmake_eval "include('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
    call:dk_check_error
goto:eof