@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
::#	  windows uninstall registry location
::#   HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\QEMU
::#
:DKINSTALL
::setlocal
    %dk_call% dk_debugFunc 0

    %dk_call% dk_validate Host_Triple "%dk_call% dk_Host_Triple"
    if defined win_x86_host     (set "QEMU_DL=https://qemu.weilnetz.de/w32/qemu-w32-setup-20240903.exe")
    if defined win_x86_64_host  (set "QEMU_DL=https://qemu.weilnetz.de/w64/qemu-w64-setup-20240903.exe")
    if not defined QEMU_DL 		(%dk_call% dk_error "QEMU_DL is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	
	%dk_call% dk_importVariables %QEMU_DL% IMPORT_PATH %~0 ROOT %DKTOOLS_DIR%
	
    ::%dk_call% dk_basename %QEMU_DL% QEMU_DL_FILE
    ::%dk_call% dk_removeExtension %QEMU_DL_FILE% QEMU_FOLDER
    ::%dk_call% dk_convertToCIdentifier %QEMU_FOLDER% QEMU_FOLDER
    ::%dk_call% dk_toLower %QEMU_FOLDER% QEMU_FOLDER
	::%dk_call% dk_importVariables %QEMU_DL%
	
	
	::%dk_call% dk_set QEMU_DIR %DKTOOLS_DIR%\%QEMU_FOLDER%
	%dk_call% dk_set QEMU_IMG_EXE %QEMU_DIR%\qemu-img.exe
	%dk_call% dk_set QEMU_SYSTEM_X86_64_EXE %QEMU_DIR%\qemu-system-x86_64.exe
	
	if exist "%QEMU_IMG_EXE%" (%return%)
	
	%dk_call% dk_download %QEMU_DL%
	%dk_call% dk_nativePath %QEMU_DIR% QEMU_INSTALL_PATH
	%dk_call% dk_echo "Installing %QEMU_DL_FILE% . . ."
	%dk_call% dk_set command_string ""%DKDOWNLOAD_DIR%\%QEMU_DL_FILE%" /S /D=%QEMU_INSTALL_PATH%"
	%dk_call% %command_string%
	
	if NOT exist "%QEMU_IMG_EXE%" (%dk_call% dk_error "cannot find qemu")
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
