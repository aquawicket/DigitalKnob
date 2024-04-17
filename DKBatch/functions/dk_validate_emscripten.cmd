::dk_include_guard()

::####################################################################
::# dk_validate_emscripten()
::#
::#
:dk_validate_emscripten () {
	call dk_verbose "dk_validate_emscripten(%*)"
	
    call dk_cmake_eval "include('%DKIMPORTS_DIR%/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
    call dk_debug EMSDK
    call dk_debug EMSDK_ENV
    call dk_debug EMSDK_GENERATOR
    call dk_debug EMSDK_TOOLCHAIN_FILE
    call dk_debug EMSDK_C_COMPILER
    call dk_debug EMSDK_CXX_COMPILER
    call dk_check_error
goto:eof