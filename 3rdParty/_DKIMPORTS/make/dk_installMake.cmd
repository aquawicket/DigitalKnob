@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installMake()
::#
:dk_installMake () {
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	call dk_printVar MAKE_PROGRAM
    call dk_checkError
goto:eof