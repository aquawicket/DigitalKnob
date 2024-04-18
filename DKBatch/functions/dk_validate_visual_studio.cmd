::dk_include_guard()

::####################################################################
::# dk_validate_visual_studio()
::#
::#
:dk_validate_visual_studio () {
	call dk_verbose "dk_validate_visual_studio(%*)"
	
    call dk_cmake_eval "dk_load('%DKIMPORTS_DIR%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
	call dk_debug VISUALSTUDIO_GENERATOR
	call dk_debug VISUALSTUDIO_X86_CXX_COMPILER
	call dk_debug VISUALSTUDIO_X64_CXX_COMPILER
    call dk_check_error
goto:eof