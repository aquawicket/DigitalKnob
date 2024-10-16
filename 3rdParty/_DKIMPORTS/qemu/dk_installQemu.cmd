@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_installQemu
::#
:dk_installQemu
    call dk_debugFunc 0

    %dk_call% dk_validate DK_HOST_OS "%dk_call% dk_getHostTriple"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     %dk_call% dk_set QEMU_DL "https://qemu.weilnetz.de/w32/qemu-w32-setup-20221230.exe"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  %dk_call% dk_set QEMU_DL "https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"
    if not defined QEMU_DL %dk_call% dk_error "QEMU_DL is invalid"

    %dk_call% dk_basename %QEMU_DL% QEMU_DL_FILE
    %dk_call% dk_removeExtension %QEMU_DL_FILE% QEMU_FOLDER
    ::%dk_call% dk_convertToCIdentifier %QEMU_FOLDER% QEMU_FOLDER
    %dk_call% dk_toLower %QEMU_FOLDER% QEMU_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_setDKTOOLS_DIR"
	%dk_call% dk_set QEMU_DIR %DKTOOLS_DIR%\%QEMU_FOLDER%
	
	%dk_call% dk_set QEMU_IMG_EXE %QEMU_DIR%\qemu-img.exe
	%dk_call% dk_set QEMU_SYSTEM_X86_64_EXE %QEMU_DIR%\qemu-system-x86_64.exe
	
	if exist "%QEMU_IMG_EXE%" goto:eof
	
	%dk_call% dk_download %QEMU_DL%
	%dk_call% dk_getNativePath %QEMU_DIR% QEMU_INSTALL_PATH
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_setDKDOWNLOAD_DIR"
	%dk_call% dk_set command_string ""%DKDOWNLOAD_DIR%\%QEMU_DL_FILE%" /D=%QEMU_INSTALL_PATH%"
	%dk_call% %command_string%
	
	if NOT exist "%QEMU_IMG_EXE%"  %dk_call% dk_error "cannot find qemu"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installQemu
%endfunction%
