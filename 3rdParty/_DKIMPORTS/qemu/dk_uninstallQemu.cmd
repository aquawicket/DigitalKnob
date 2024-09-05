@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0


::####################################################################
::# dk_uninstallQemu()
::#
:dk_uninstallQemu
	call dk_debugFunc 0
	
	
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     call dk_set QEMU_DL "https://qemu.weilnetz.de/w32/qemu-w32-setup-20221230.exe"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  call dk_set QEMU_DL "https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"
	
	call dk_basename %QEMU_DL% QEMU_DL_NAME
	call dk_convertToCIdentifier %QEMU_DL_NAME% QEMU_DL_NAME
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_info "%DKTOOLS_DIR%\%QEMU_DL_NAME%\qemu-uninstall.exe"
	call "%DKTOOLS_DIR%\%QEMU_DL_NAME%\qemu-uninstall.exe"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallQemu
%endfunction%
