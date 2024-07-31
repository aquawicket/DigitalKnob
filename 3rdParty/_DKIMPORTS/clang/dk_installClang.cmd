@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installClang()
::#
:dk_installClang
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/clang/DKMAKE.cmake')" "CLANG_EXE;CLANGXX_EXE"
	call dk_printVar CLANG_EXE
	call dk_printVar CLANGXX_EXE
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installClang
goto:eof
