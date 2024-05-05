@echo off

call "../../../DKBatch/functions/DK.cmd"
call dk_includeGuard


:dk_validateQemu () {
	call dk_debugFunc
	
	call dk_getDKPaths
	call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/qemu/DKMAKE.cmake')" "QEMU_EXE"
	call dk_printVar QEMU_EXE
goto:eof