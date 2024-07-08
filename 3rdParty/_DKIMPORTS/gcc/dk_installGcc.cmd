@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installGcc()
::#
:dk_installGcc
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	call dk_printVar GCC_C_COMPILER
	call dk_printVar GCC_CXX_COMPILER
goto:eof