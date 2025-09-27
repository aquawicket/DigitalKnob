@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
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
	
	%dk_call% dk_import APP
	%dk_call% dk_assertVar QEMU

	%dk_call% dk_set qemu_img_exe %QEMU%/qemu-img.exe
	%dk_call% dk_set qemu-system-x86_64_exe %QEMU%/qemu-system-x86_64.exe
	
	if EXIST "%qemu_img_exe%" (%return%)
	%dk_call% dk_echo "Installing %PLUGIN_Url_Basename% . . ."
	
	::C:\Users\Administrator\DigitalKnob\download\qemu-w64-setup-20250806.exe /D=C:\Users\Administrator\DigitalKnob\DKTools\qemu-w64-setup-20250806
	set "dk_exec_PRINT_COMMAND=1"
	set QEMU_WIN=%QEMU:/=\%
	::FIXME: using dk_exec causes the installer to ignore the /D path
	::%dk_call% dk_exec %dk_download:/=\% /D=%QEMU_WIN%
	%dk_download:/=\% /S /D=%QEMU_WIN%
	
	%dk_call% dk_assertPath "%qemu_img_exe%"
%endfunction%

