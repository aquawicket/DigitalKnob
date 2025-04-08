@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0
	
	set "TINYCORELINUX_RPI=http://www.tinycorelinux.net/15.x/aarch64/test_releases/RPi/piCore64-15.0.0-beta2.zip"
	set "TINYCORELINUX_X86=http://www.tinycorelinux.net/15.x/x86/release/Core-current.iso"
	set "TINYCORELINUX_X86_64=http://www.tinycorelinux.net/15.x/x86_64/release/CorePure64-current.iso"
	set "TINYCORELINUX_DL=%TINYCORELINUX_X86_64%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set TINYCORELINUX_DIR "%DKTOOLS_DIR%\TinyCoreLinux"
	%dk_call% dk_set TINYCORELINUX_IMG %TINYCORELINUX_DIR%\tinycore.img
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate QEMU_IMG_EXE "%dk_call% %DKIMPORTS_DIR%\qemu\DKINSTALL.cmd"
	
	setlocal
		if exist "%TINYCORELINUX_IMG%" (%return%)
		
		%dk_call% dk_info "Installing tiny-core-linux . . ."
		%dk_call% dk_basename %TINYCORELINUX_DL% TINYCORELINUX_DL_FILE
		%dk_call% dk_download %TINYCORELINUX_DL%
		
		::###### create and cd into install directory ######
		%dk_call% dk_makeDirectory %TINYCORELINUX_DIR% 
		%dk_call% dk_chdir %TINYCORELINUX_DIR%
		
		::###### Install the OS to the .img file ######
		::###### (Install from the running virtual OS) ######
		%dk_call% dk_info "########### Tiny Core Linux -install- ###############"
		%dk_call% dk_echo
		%dk_call% dk_info ". Choose:  Boot Core with X/GUI (TinyCore) - Installation Extension"
		%dk_call% dk_info ". Click Tc-install icon to install   (bottom right)"
		%dk_call% dk_info ". Check Frugal, Whole Disc, sda1,  install bootloader, and click next"
		%dk_call% dk_info ". ext4 and click next"
		%dk_call% dk_info ". choose any advanced options if needed.  (next)"
		%dk_call% dk_info ". check Core and X/GUI Desktop.  check wifi and all the other boxes as well (proceed)"
		%dk_call% dk_info ". Give the install process a moment to format and install.."
		%dk_call% dk_echo
		%dk_call% dk_info ". When instal finishes, shut down."
		%dk_call% dk_info ". A LAUNCH shortcut will be created the int DKTools/TinyCoreLinux directory"
		
		::###### Create the virtual image (10gb) ######
		%QEMU_IMG_EXE% create -f qcow2 %TINYCORELINUX_IMG% 10G
		
		::###### Launching the VM ######
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%QEMU_SYSTEM_X86_64_EXE% -cdrom %DKDOWNLOAD_DIR%/%TINYCORELINUX_DL_FILE% -boot menu=on -drive file=%TINYCORELINUX_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	
		::###### create TinyCoreLinux Launcher ######
		%dk_call% dk_set TINYCORELINUX_launcher "%TINYCORELINUX_DIR%\LAUNCH.cmd"
		if exist "%TINYCORELINUX_launcher%" (%return%)
		%dk_call% dk_fileWrite "%TINYCORELINUX_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=%TINYCORELINUX_IMG% -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%
	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%