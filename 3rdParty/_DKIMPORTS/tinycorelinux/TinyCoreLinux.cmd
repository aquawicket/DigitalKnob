@echo off

set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"
set "TINYCORELINUX_IMG=tinycore.img"
::set "QEMU=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\qemu"
set "QEMU=%HOMEDRIVE%%HOMEPATH%\digitalknob\DKTools\qemu"
set "QEMU_MEMORY=1G"
set "QEMU_DRIVE_SIZE=10G"


::###### DK_Init ######
call ../../../DKBatch/functions/DK.cmd


:: Install instructions ::
:: select Frugal
:: select sda
:: check online

:: delete tinycore.img to redo the process if needed


if NOT exist "%TINYCORELINUX_IMG%" (
	call:download_iso
	goto:end
)
if exist "%TINYCORELINUX_IMG%" (
	call:launch
	goto:end
)


::--------------------------------------------------------
:: FUNCTIONS
:: https://www.dostips.com/DtTutoFunctions.php
::--------------------------------------------------------


:: Download CorePlus-current.iso
:download_iso
	call dk_getFilename %TINYCORELINUX_DL% TINYCORELINUX_DL_FILE
	if NOT exist "%TINYCORELINUX_DL_FILE%" (
		call dk_info "Downloading CorePlus-current.iso . . ."
		call dk_download %TINYCORELINUX_DL% %TINYCORELINUX_DL_FILE%
	)
	call:create_image
goto:eof

:: Create the virtual image (10gb)
:create_image
	if exist "%TINYCORELINUX_IMG%" (
		call dk_warning "%TINYCORELINUX_IMG% already exists"
	)
	call dk_info "Creating %TINYCORELINUX_IMG% . . ."
	
	%QEMU%\qemu-img create -f qcow2 %TINYCORELINUX_IMG% %QEMU_DRIVE_SIZE%
	
	if "%ERRORLEVEL%" NEQ "0" (
		call dk_remove %TINYCORELINUX_IMG%
		call dk_error "Failed to create image"
	)

	call:install
goto:eof

:: Launching the VM with CD to install
:install
	call dk_info "Installing TinyCoreLinux . . ."
	call dk_getFilename %TINYCORELINUX_DL% TINYCORELINUX_DL_FILE
	%QEMU%\qemu-system-x86_64 -cdrom %TINYCORELINUX_DL_FILE% -boot menu=on -drive file=%TINYCORELINUX_IMG% -m %QEMU_MEMORY% -cpu max -smp 2 -vga virtio -display sdl
	if NOT "%ERRORLEVEL%" == "0" (
		call dk_remove %TINYCORELINUX_IMG%
		call dk_error "Launching the virtual maching failed"
	)
	call dk_echo "Installation complete"
goto:eof

:: Launching the VM (after install)
:launch
	call dk_info "Starting up TinyCoreLinux . . ."
	start "" %QEMU%\qemu-system-x86_64 -boot menu=on -drive file=%TINYCORELINUX_IMG% -m %QEMU_MEMORY% -cpu max -smp 2 -vga virtio -display sdl
goto:eof


:end
call dk_exit