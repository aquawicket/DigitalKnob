@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_installClang()
::#
:dk_installClang
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/clang/DKMAKE.cmake')" "CLANG_EXE;CLANGXX_EXE"
	call dk_printVar CLANG_EXE
	call dk_printVar CLANGXX_EXE
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installClang
goto:eof
