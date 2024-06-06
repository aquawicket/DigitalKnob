@echo off
call "../../../DKBatch/functions/DK.cmd"


set "TINYCORELINUX_DL=http://tinycorelinux.net/14.x/x86/release/CorePlus-current.iso"

call :dk_installTinyCoreLinux
call :dk_createTinyCoreLinuxLaunch
goto:eof

::####################################################################
::# dk_installTinyCoreLinux()
::#
:dk_installTinyCoreLinux () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_set TINYCORELINUX "%DKTOOLS_DIR%\TinyCoreLinux"
	call dk_set TINYCORELINUX_IMG %TINYCORELINUX%\tinycore.img
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate QEMU_IMG_EXE "call %DKIMPORTS_DIR%\qemu\dk_installQemu.cmd"
	
	setlocal
		if exist "%TINYCORELINUX_IMG%" goto:eof
		
		call dk_info "Installing tiny-core-linux . . ."
		call dk_getFilename %TINYCORELINUX_DL% TINYCORELINUX_DL_FILE
		call dk_download %TINYCORELINUX_DL% %DKDOWNLOAD_DIR%\%TINYCORELINUX_DL_FILE%
		
		:: create and cd into install directory
		call dk_makeDirectory %TINYCORELINUX% 
		cd %TINYCORELINUX%
		
		:::::: Install the OS to the .img file
		:: (Install from the running virtual OS)
		call dk_info "########### Tiny Core Linux -install- ###############"
		call dk_info " "
		call dk_info ". Choose:  Boot Core with X/GUI (TinyCore) - Installation Extension"
		call dk_info ". Click Tc-install icon to install   (bottom right)"
		call dk_info ". Check Frugal, Whole Disc, sda1,  install bootloader, and click next"
		call dk_info ". ext4 and click next"
		call dk_info ". choose any advanced options if needed.  (next)"
		call dk_info ". check Core and X/GUI Desktop.  check wifi and all the other boxes as well (proceed)"
		call dk_info ". Give the install process a moment to format and install.."
		call dk_info " "
		call dk_info ". When instal finishes, shut down."
		call dk_info ". A LAUNCH shortcut will be created the int DKTools/TinyCoreLinux directory"
		
		:::::: Create the virtual image (10gb)
		%QEMU_IMG_EXE% create -f qcow2 %TINYCORELINUX_IMG% 10G
		
		:: Launching the VM
		%QEMU_SYSTEM_X86_64_EXE% -cdrom %DKDOWNLOAD_DIR%/CorePlus-current.iso -boot menu=on -drive file=%TINYCORELINUX_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	
	endlocal
goto:eof

::####################################################################
::# dk_createTinyCoreLinuxLaunch()
::#
:dk_createTinyCoreLinuxLaunch
	setlocal
		:: Create LAUNCH.cmd file
		call dk_set TINYCORELINUX_launcher "%TINYCORELINUX%\LAUNCH.cmd"
		if exist "%TINYCORELINUX_launcher%" goto:eof	
		call dk_fileWrite "%TINYCORELINUX_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=%TINYCORELINUX_IMG% -cpu max -smp 2 -vga virtio -display sdl"
	endlocal
goto:eof
	
	
	:: install via CMake
::	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
::	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
::  call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/tinycorelinux/DKMAKE.cmake')" "TINYCORELINUX"
::	call dk_printVar TINYCORELINUX
