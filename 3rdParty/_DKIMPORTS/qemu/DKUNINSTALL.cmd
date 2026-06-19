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


rem ####################################################################
rem # DKUNINSTALL()
rem #
rem #	  windows uninstall registry location
rem #   HKLM/Software/Microsoft/Windows/CurrentVersion/Uninstall/qemu
rem #
:DKUNINSTALL
rem %setlocal%
	
	if defined Windows_X86_Host      (set "qemu_Import=https://qemu.weilnetz.de/w32/qemu-w32-setup-20221230.exe")
	if defined Windows_X86_64_Host   (set "qemu_Import=https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe")
	
	%dk_call% dk_basename %qemu_Import% qemu_Import_File
    %dk_call% dk_removeExtension %qemu_Import_File% qemu_Install_Name
    rem %dk_call% dk_convertToCIdentifier %qemu_Install_Name% qemu_Install_Name
    %dk_call% dk_toLower %qemu_Install_Name% qemu_Install_Name
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_set qemu_DIR %DKTOOLS_DIR%/%qemu_Install_Name%
	
	%dk_call% dk_info "%qemu_DIR%/qemu-uninstall.exe"
	%dk_call% "%qemu_DIR:/=\%\qemu-uninstall.exe"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%
