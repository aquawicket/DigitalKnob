@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_installMsys2()
::#
:dk_installMsys2
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/msys2/DKMAKE.cmake')" "MSYS2;MSYS2_GENERATOR"
	call dk_printVar MSYS2
	call dk_printVar MSYS2_GENERATOR
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installMsys2
goto:eof
