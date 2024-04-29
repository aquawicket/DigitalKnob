@echo off


call "../../../DKBatch/functions/DK.cmd"
call dk_includeGuard


:dk_validateTinyCoreLinux () {
	call dk_debugFunc
	
	call dk_getDKPaths
	call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/tinycorelinux/DKMAKE.cmake')" "TINYCORELINUX"
	call dk_debug TINYCORELINUX
goto:eof