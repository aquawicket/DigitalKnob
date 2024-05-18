@echo off

set	"QEMU_DL=https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"


call "../../../DKBatch/functions/DK.cmd"
call dk_includeGuard


:dk_validateQemu () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_getDKPaths
	call dk_validateBranch
    call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/qemu/DKMAKE.cmake')" "QEMU_IMG_EXE"
	call dk_printVar QEMU_IMG_EXE
goto:eof