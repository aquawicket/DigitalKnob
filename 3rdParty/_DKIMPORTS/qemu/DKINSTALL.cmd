@echo off&::###### DK.cmd #########################################################################################################################
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
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables !qemu_%Host_Tuple%_Import! Install.Dirname %DKTOOLS_DIR%
    %dk_call% dk_assertVar QEMU
	
	%dk_call% dk_set QEMU_IMG_EXE %QEMU%/qemu-img.exe
	%dk_call% dk_set QEMU_SYSTEM_X86_64_EXE %QEMU%/qemu-system-x86_64.exe
	
	if exist "%QEMU_IMG_EXE%" (%return%)
	%dk_call% dk_download %QEMU.Url%
	%dk_call% dk_nativePath %QEMU% QEMU_NATIVE
	%dk_call% dk_echo "Installing %QEMU.Url.Bsename% . . ."
	%dk_call% dk_exec cmd /c "%dk_download%" /S /D=%QEMU:/=\%
	
	%dk_call% dk_assertPath "%QEMU_IMG_EXE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
