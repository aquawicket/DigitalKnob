@echo off
call "../../../DKBatch/functions/DK.cmd"


set	"QEMU_DL=https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"


:dk_uninstallQemu () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_getName %QEMU_DL% QEMU_DL_NAME
	call dk_convertToCIdentifier %QEMU_DL_NAME% QEMU_DL_NAME
	call dk_validate DKTOOLS_DIR dk_getDKPaths
	call dk_info "%DKTOOLS_DIR%\%QEMU_DL_NAME%\qemu-uninstall.exe"
	call "%DKTOOLS_DIR%\%QEMU_DL_NAME%\qemu-uninstall.exe"
goto:eof





:DKTEST ########################################################################

	call dk_uninstallQemu