rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ###################### qemu ######################
rem # https://www.qemu.org
rem # https://qemu.weilnetz.de/w64/2022/qemu-w64-setup-20221230.exe
rem # https://azeria-labs.com/emulate-raspberry-pi-with-qemu	# Emulate Raspberry Pi
rem # https://qemu.weilnetz.de/w32/2022/qemu-w32-setup-20221230.exe
rem # https://qemu.weilnetz.de/w64/2025/qemu-w64-setup-20250806.exe

:DKINSTALL
rem %setlocal%
	
	%dk_call% dk_import

	%dk_call% dk_set qemu_img_exe %QEMU%/qemu-img.exe
	%dk_call% dk_set qemu-system-x86_64_exe %QEMU%/qemu-system-x86_64.exe
	
	if EXIST "%qemu_img_exe%" (%return%)
	%dk_call% dk_echo "Installing %PLUGIN_Url_Basename% . . ."
	
	
	set qemu_Windows=%qemu:/=\%
	rem FIXME: using dk_exec causes the installer to ignore the /D path
	rem set "dk_exec_PRINT_COMMAND=1"
	rem %dk_call% dk_exec %dk_download:/=\% /D=%QEMU_WIN%
	
	rem C:/Users/Administrator/Digital Knob/download/qemu-w64-setup-20250806.exe /D=C:/Users/Administrator/Digita lKnob/DKTools/qemu-w64-setup-20250806
	%dk_download:/=\% /S /D=%Qemu_Windows%
	
	%dk_call% dk_assertPath "%qemu_img_exe%"
%endfunction%

