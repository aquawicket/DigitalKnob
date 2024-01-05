@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

::set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"
::set "TINYCORELINUX_ISO=%cd%\CorePlus-current.iso"

set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/TinyCore-current.iso"
set "TINYCORELINUX_ISO=%cd%\TinyCore-current.iso"

set "TINYCORELINUX_IMG=tinycore.img"
set "QEMU=C:\Users\Administrator\digitalknob\Development\3rdParty\qemu"


if NOT exist "%TINYCORELINUX_ISO%" (
	call:download %TINYCORELINUX_DL% %TINYCORELINUX_ISO%
)

:: cd <iso directory>
:: already there

:: Create the virtual image (10gb)
if exist "%TINYCORELINUX_IMG%" (
	del "%TINYCORELINUX_IMG%"
)
%QEMU%\qemu-img create -f qcow2 %TINYCORELINUX_IMG% 10G

:: Launching the VM
%QEMU%\qemu-system-x86_64 -cdrom %TINYCORELINUX_ISO% -boot menu=on -drive file=%TINYCORELINUX_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl

:: Install the OS to the .img file
:: (Install from the running virtual OS)



:: download()
:download
	echo Downloading %~1 to %~2
	if exist "%~2" (
		echo %~2 already exist
	)
	if NOT exist "%~2" (
		echo please wait . . .
		certutil.exe -urlcache -split -f %~1 %~2
	)
	::call:check_error
goto:eof
