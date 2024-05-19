@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installMsys2()
::#
:dk_installMsys2 () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR "dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
	call dk_printVar MSYS2
	call dk_printVar MSYS2_GENERATOR
goto:eof