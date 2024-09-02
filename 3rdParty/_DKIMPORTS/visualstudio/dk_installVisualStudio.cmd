@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_installVisualStudio()
::#
::#
:dk_installVisualStudio
	call dk_debugFunc 0	
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
	call dk_printVar VISUALSTUDIO_GENERATOR
	call dk_printVar VISUALSTUDIO_X86_CXX_COMPILER
	call dk_printVar VISUALSTUDIO_X64_CXX_COMPILER
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installVisualStudio
goto:eof