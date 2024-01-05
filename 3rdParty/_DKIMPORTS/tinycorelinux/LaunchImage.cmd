@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) :: keep window open

set "QEMU=C:\Users\Administrator\digitalknob\Development\3rdParty\qemu"
set "TINYCORELINUX_IMG=tinycore.img"

:: Launching the VM without cdrom (after install)
:: cd <iso directory>
%QEMU%\qemu-system-x86_64 -boot menu=on -drive file=%TINYCORELINUX_IMG% -cpu max -smp 2 -vga virtio -display sdl
