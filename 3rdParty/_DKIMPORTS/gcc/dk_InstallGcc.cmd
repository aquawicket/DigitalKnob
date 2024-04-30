@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::####################################################################
::# dk_InstallGcc()
::#
::#
:dk_InstallGcc () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	call dk_debug GCC_C_COMPILER
	call dk_debug GCC_CXX_COMPILER
goto:eof