@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::####################################################################
::# dk_installQemu
::#
:dk_installQemu
    call dk_debugFunc 0

    call dk_validate HOST_OS "call dk_getHostTriple"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set QEMU_DL "https://qemu.weilnetz.de/w32/qemu-w32-setup-20221230.exe"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set QEMU_DL "https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"
    if not defined QEMU_DL call dk_error "QEMU_DL is invalid"

    call dk_basename %QEMU_DL% QEMU_DL_FILE
    call dk_removeExtension %QEMU_DL_FILE% QEMU_NAME
    call dk_convertToCIdentifier %QEMU_NAME% QEMU_FOLDER
    call dk_toLower %QEMU_FOLDER% QEMU_FOLDER
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set QEMU_DIR %DKTOOLS_DIR%\%QEMU_FOLDER%
	call dk_set QEMU_IMG_EXE %QEMU_DIR%\qemu-img.exe
	call dk_set QEMU_SYSTEM_X86_64_EXE %QEMU_DIR%\qemu-system-x86_64.exe
	
	if exist "%QEMU_IMG_EXE%" goto:eof
	
	call dk_download %QEMU_DL%
	call dk_getNativePath %QEMU_DIR% QEMU_INSTALL_PATH
	call dk_set command_string ""%DKDOWNLOAD_DIR%\%QEMU_DL_FILE%" /D=%QEMU_INSTALL_PATH%"
	call %command_string%
	
	if NOT exist "%QEMU_IMG_EXE%"  call dk_error "cannot find qemu"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installQemu
goto:eof
