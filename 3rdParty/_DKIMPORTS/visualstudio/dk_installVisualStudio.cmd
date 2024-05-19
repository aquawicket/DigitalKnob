@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installVisualStudio()
::#
::#
:dk_installVisualStudio () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR "dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/visualstudio/DKMAKE.cmake')" "VISUALSTUDIO_GENERATOR;VISUALSTUDIO_X86_CXX_COMPILER;VISUALSTUDIO_X64_CXX_COMPILER;"
	call dk_printVar VISUALSTUDIO_GENERATOR
	call dk_printVar VISUALSTUDIO_X86_CXX_COMPILER
	call dk_printVar VISUALSTUDIO_X64_CXX_COMPILER
    call dk_checkError
goto:eof