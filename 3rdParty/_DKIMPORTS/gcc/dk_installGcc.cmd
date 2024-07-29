@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installGcc()
::#
:dk_installGcc
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	::set "MSYSTEM=CLANG64"
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_EXE;GXX_EXE"
	call dk_printVar GCC_EXE
	call dk_printVar GXX_EXE
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installGcc
goto:eof
