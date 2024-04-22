::dk_include_guard()

::####################################################################
::# dk_validate_gcc()
::#
::#
:dk_validate_gcc () {
	call dk_verbose "dk_validate_gcc(%*)"
	
	if "%DKIMPORTS_DIR%"==""  call dk_validate_branch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	call dk_debug GCC_C_COMPILER
	call dk_debug GCC_CXX_COMPILER
    call dk_checkError
goto:eof