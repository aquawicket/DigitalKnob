@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_uninstallQemu()
::#
:dk_uninstallQemu
	call dk_debugFunc 0
	
	
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86"     call dk_set QEMU_DL "https://qemu.weilnetz.de/w32/qemu-w32-setup-20221230.exe"
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64"  call dk_set QEMU_DL "https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"
	
	call dk_basename %QEMU_DL% QEMU_DL_FILE
    call dk_removeExtension %QEMU_DL_FILE% QEMU_FOLDER
    ::call dk_convertToCIdentifier %QEMU_FOLDER% QEMU_FOLDER
    call dk_toLower %QEMU_FOLDER% QEMU_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_DKTOOLS_DIR"
	call dk_set QEMU_DIR %DKTOOLS_DIR%\%QEMU_FOLDER%
	
	call dk_info "%QEMU_DIR%\qemu-uninstall.exe"
	call "%QEMU_DIR%\qemu-uninstall.exe"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallQemu
%endfunction%
