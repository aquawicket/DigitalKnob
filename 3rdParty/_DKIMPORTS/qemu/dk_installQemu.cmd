@echo off
call "../../../DKBatch/functions/DK.cmd"


set	"QEMU_DL=https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"


:dk_installQemu () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_getFilename %QEMU_DL% QEMU_DL_FILE
	call dk_removeExtension %QEMU_DL_FILE% QEMU_NAME
	call dk_convertToCIdentifier %QEMU_NAME% QEMU_FOLDER
	call dk_validate DKTOOLS_DIR dk_getDKPaths
	call dk_set QEMU %DKTOOLS_DIR%\%QEMU_FOLDER%
	call dk_set QEMU_IMG_EXE %QEMU%\qemu-img.exe
	call dk_set QEMU_SYSTEM_X86_64_EXE %QEMU%\qemu-system-x86_64.exe
	
	if exist "%QEMU_IMG_EXE%" goto:eof
	
	call dk_download %QEMU_DL% %DKDOWNLOAD_DIR%\%QEMU_DL_FILE%
	call dk_getNativePath %QEMU% QEMU_INSTALL_PATH
	call dk_set command_string ""%DKDOWNLOAD_DIR%\%QEMU_DL_FILE%" /D=%QEMU_INSTALL_PATH%"
	call %command_string%

	:: install via CMake
::  call dk_getDKPaths
::	call dk_validateBranch
::  call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/qemu/DKMAKE.cmake')" "QEMU_IMG_EXE"
::	call dk_printVar QEMU_IMG_EXE
goto:eof




:DKTEST ########################################################################

	call dk_installQemu