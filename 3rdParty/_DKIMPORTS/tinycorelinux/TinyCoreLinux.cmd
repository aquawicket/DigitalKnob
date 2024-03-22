@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

:: Install instructions ::
:: select Frugal
:: select sda
:: check online

:: delete tinycore.img to redo the process if needed

set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"
set "TINYCORELINUX_ISO=%cd%\CorePlus-current.iso"
set "TINYCORELINUX_IMG=tinycore.img"
set "QEMU=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\qemu"
set "QEMU_MEMORY=1G"
set "QEMU_DRIVE_SIZE=10G"


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

:: assert()
:assert
	echo ERROR:%ERRORLEVEL%  %~1
	pause
	exit
goto:eof


:: Download CorePlus-current.iso
:download_iso
	if NOT exist "%TINYCORELINUX_ISO%" (
		echo "Downloading CorePlus-current.iso . . ."
		call:download %TINYCORELINUX_DL% %TINYCORELINUX_ISO%
	)
	call::create_image
goto:eof

:: Create the virtual image (10gb)
:create_image
	if exist "%TINYCORELINUX_IMG%" (
		call:assert "%TINYCORELINUX_IMG% already exists"
	)
	echo "Creating %TINYCORELINUX_IMG% . . ."
	%QEMU%\qemu-img create -f qcow2 %TINYCORELINUX_IMG% %QEMU_DRIVE_SIZE%
	
	if NOT "%ERRORLEVEL%" == "0" (
		del %TINYCORELINUX_IMG%
		call:assert "Failed to create image"
	)

	call:install
goto:eof

:: Launching the VM with CD to install
:install
	echo "Installing TinyCoreLinux . . ."
	%QEMU%\qemu-system-x86_64 -cdrom %TINYCORELINUX_ISO% -boot menu=on -drive file=%TINYCORELINUX_IMG% -m %QEMU_MEMORY% -cpu max -smp 2 -vga virtio -display sdl
	if NOT "%ERRORLEVEL%" == "0" (
		del %TINYCORELINUX_IMG%
		call:assert "Launching the virtual maching failed"
	)
	echo "Installation complete"
goto:eof

:: Launching the VM (after install)
:launch
	echo "Starting up TinyCoreLinux . . ."
	start "" %QEMU%\qemu-system-x86_64 -boot menu=on -drive file=%TINYCORELINUX_IMG% -m %QEMU_MEMORY% -cpu max -smp 2 -vga virtio -display sdl
goto:eof

:: download file()
:download
	echo Downloading %~1 to %~2
	if exist "%~2" (
		echo %~2 already exist
	)
	if NOT exist "%~2" (
		echo please wait . . .
		certutil.exe -urlcache -split -f %~1 %~2
	)
goto:eof

:end
exit