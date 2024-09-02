@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_installTinyCoreLinux
::#
:dk_installTinyCoreLinux
	call dk_debugFunc 0
	
	set "TINYCORELINUX_RPI=http://www.tinycorelinux.net/15.x/aarch64/test_releases/RPi/piCore64-15.0.0-beta2.zip"
	set "TINYCORELINUX_X86=http://www.tinycorelinux.net/15.x/x86/release/Core-current.iso"
	set "TINYCORELINUX_X86_64=http://www.tinycorelinux.net/15.x/x86_64/release/CorePure64-current.iso"
	set "TINYCORELINUX_DL=%TINYCORELINUX_X86_64%"
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set TINYCORELINUX_DIR "%DKTOOLS_DIR%\TinyCoreLinux"
	call dk_set TINYCORELINUX_IMG %TINYCORELINUX_DIR%\tinycore.img
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate QEMU_IMG_EXE "call %DKIMPORTS_DIR%\qemu\dk_installQemu.cmd"
	
	setlocal
		if exist "%TINYCORELINUX_IMG%" goto:eof
		
		call dk_info "Installing tiny-core-linux . . ."
		call dk_basename %TINYCORELINUX_DL% TINYCORELINUX_DL_FILE
		call dk_download %TINYCORELINUX_DL%
		
		:: create and cd into install directory
		call dk_makeDirectory %TINYCORELINUX_DIR% 
		cd %TINYCORELINUX_DIR%
		
		:::::: Install the OS to the .img file
		:: (Install from the running virtual OS)
		call dk_info "########### Tiny Core Linux -install- ###############"
		call dk_echo
		call dk_info ". Choose:  Boot Core with X/GUI (TinyCore) - Installation Extension"
		call dk_info ". Click Tc-install icon to install   (bottom right)"
		call dk_info ". Check Frugal, Whole Disc, sda1,  install bootloader, and click next"
		call dk_info ". ext4 and click next"
		call dk_info ". choose any advanced options if needed.  (next)"
		call dk_info ". check Core and X/GUI Desktop.  check wifi and all the other boxes as well (proceed)"
		call dk_info ". Give the install process a moment to format and install.."
		call dk_echo
		call dk_info ". When instal finishes, shut down."
		call dk_info ". A LAUNCH shortcut will be created the int DKTools/TinyCoreLinux directory"
		
		:::::: Create the virtual image (10gb)
		%QEMU_IMG_EXE% create -f qcow2 %TINYCORELINUX_IMG% 10G
		
		:: Launching the VM
		%QEMU_SYSTEM_X86_64_EXE% -cdrom %DKDOWNLOAD_DIR%/%TINYCORELINUX_DL_FILE% -boot menu=on -drive file=%TINYCORELINUX_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	
		:: create TinyCoreLinux Launcher
		call dk_set TINYCORELINUX_launcher "%TINYCORELINUX_DIR%\LAUNCH.cmd"
		if exist "%TINYCORELINUX_launcher%" goto:eof	
		call dk_fileWrite "%TINYCORELINUX_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=%TINYCORELINUX_IMG% -cpu max -smp 2 -vga virtio -display sdl"
	
	endlocal
goto:eof
	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installTinyCoreLinux
goto:eof