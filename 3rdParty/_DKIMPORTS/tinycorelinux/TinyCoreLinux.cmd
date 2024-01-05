@echo off
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

:: Install instructions ::
:: select Frugal
:: select sda
:: check online

:: delete tinycore.img to redo the process if needed

set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"
set "TINYCORELINUX_ISO=%cd%\CorePlus-current.iso"
set "TINYCORELINUX_IMG=tinycore.img"
set "QEMU=C:\Users\Administrator\digitalknob\Development\3rdParty\qemu"


if NOT exist "%TINYCORELINUX_IMG%" (
	call:download_iso
)
if exist "%TINYCORELINUX_IMG%" (
	call:launch
)

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
	echo "Creating %TINYCORELINUX_IMG% . . ."
	if exist "%TINYCORELINUX_IMG%" (
		del "%TINYCORELINUX_IMG%"
	)
	%QEMU%\qemu-img create -f qcow2 %TINYCORELINUX_IMG% 10G
	call:install
goto:eof

:: Launching the VM with CD to install
:install
	echo "Installing TinyCoreLinux . . ."
	%QEMU%\qemu-system-x86_64 -cdrom %TINYCORELINUX_ISO% -boot menu=on -drive file=%TINYCORELINUX_IMG% -m 1.5G -cpu max -smp 2 -vga virtio -display sdl
	echo "Installation complete"
	pause
	call:launch
goto:eof

:: Launching the VM (after install)
:launch
	echo "Starting up TinyCoreLinux . . ."
	%QEMU%\qemu-system-x86_64 -boot menu=on -drive file=%TINYCORELINUX_IMG% -cpu max -smp 2 -vga virtio -display sdl
	goto:end
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
