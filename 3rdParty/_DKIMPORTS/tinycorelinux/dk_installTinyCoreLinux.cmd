@echo off
call "../../../DKBatch/functions/DK.cmd"


set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"


:dk_installTinyCoreLinux () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_validate DKTOOLS_DIR dk_getDKPaths
	set "TINYCORELINUX=%DKTOOLS_DIR%\TinyCoreLinux"
	
	if exist "%TINYCORELINUX%\tinycore.img" goto:eof
	
	call dk_info "Installing tiny-core-linux . . ."
	call dk_getFilename %TINYCORELINUX_DL% TINYCORELINUX_DL_FILE
	call dk_download %TINYCORELINUX_DL% %DKDOWNLOAD_DIR%/%TINYCORELINUX_DL_FILE%
	
	:: cd into install directory
	::dk_setPath %TINYCORELINUX%
	
	:::::: Create the virtual image (10gb)
	call dk_validate QEMU_IMG_EXE "../qemu/dk_installQemu.cmd"
	
	:: C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-img create -f qcow2 tinycore.img 10G
	%QEMU_IMG_EXE% create -f qcow2 tinycore.img 10G
	
	:: Launching the VM
	:: C:/Users/Administrator/digitalknob/Development/3rdParty/qemu/qemu-system-x86_64 -cdrom CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl
	%QEMU_SYSTEM_X86_64_EXE% -cdrom %DKDOWNLOAD_DIR%/CorePlus-current.iso -boot menu=on -drive file=tinycore.img -m 1G -cpu max -smp 2 -vga virtio -display sdl

	:::::: Install the OS to the .img file
	:: (Install from the running virtual OS)
	call dk_info "########### Tiny Core Linux -install- ###############"
	call dk_info " "
	call dk_info ". Choose:  Boot Core with X/GUI (TinyCore) - Installation Extension"
	call dk_info ". Click Tc-install icon to install   (bottom right)"
	call dk_info ". Check Frugal, Whole Disc, sda1,  install bootloader, and click next"
	call dk_info ". ext4 and click next"
	call dk_info ". choose any advanced options if needed.  (next)"
	call dk_info ". check Core and X/GUI Desktop.  check wifi and all the other boxes as well (next)"
	call dk_info ". Give the install process a moment to format and install.."
	call dk_info " "
	call dk_info ". When instal finishes, shut down."
	call dk_info ". A LAUNCH shortcut will be created the int DKTools/TinyCoreLinux directory"
	
	
	dk_set TINYCOURLINUX_launcher "%TINYCORELINUX%/LAUNCH.cmd"
	if exist "%TINYCOURLINUX_launcher%" goto:eof
		
	dk_fileWrite "%TINYCOURLINUX_launcher%" "@echo off && start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=tinycore.img -cpu max -smp 2 -vga virtio -display sdl"

	:: install via CMake
::	call dk_validate DIGITALKNOB_DIR dk_getDKPaths
::	call dk_validate DKIMPORTS_DIR dk_validateBranch
::  call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/tinycorelinux/DKMAKE.cmake')" "TINYCORELINUX"
::	call dk_printVar TINYCORELINUX
goto:eof