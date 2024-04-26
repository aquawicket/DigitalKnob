call dk_includeGuard

::####################################################################
::# dk_validateVisualStudio()
::#
::#
:dk_validateVisualStudio () {
	call dk_debugFunc
	
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
	call dk_debug VISUALSTUDIO_GENERATOR
	call dk_debug VISUALSTUDIO_X86_CXX_COMPILER
	call dk_debug VISUALSTUDIO_X64_CXX_COMPILER
    call dk_checkError
goto:eof