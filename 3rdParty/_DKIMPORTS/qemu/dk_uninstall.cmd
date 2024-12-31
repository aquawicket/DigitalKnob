@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_uninstall()
::#
::#	  windows uninstall registry location
::#   HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\QEMU
::#
:dk_uninstall
	%dk_call% dk_debugFunc 0
	
	if defined win_x86_host      set "QEMU_DL=https://qemu.weilnetz.de/w32/qemu-w32-setup-20221230.exe"
	if defined win_x86_64_host   set "QEMU_DL=https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe"
	
	%dk_call% dk_basename %QEMU_DL% QEMU_DL_FILE
    %dk_call% dk_removeExtension %QEMU_DL_FILE% QEMU_FOLDER
    ::%dk_call% dk_convertToCIdentifier %QEMU_FOLDER% QEMU_FOLDER
    %dk_call% dk_toLower %QEMU_FOLDER% QEMU_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set QEMU_DIR %DKTOOLS_DIR%\%QEMU_FOLDER%
	
	%dk_call% dk_info "%QEMU_DIR%\qemu-uninstall.exe"
	%dk_call% "%QEMU_DIR%\qemu-uninstall.exe"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_uninstall
%endfunction%
