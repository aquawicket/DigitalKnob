@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:: https://reactos.org
:: https://reactos.org/wiki/QEMU

::####################################################################
::# dk_installReactOS()
::#
:dk_installReactOS
	call dk_debugFunc 0
	
	set "REACTOS_DL=https://sourceforge.net/projects/reactos/files/ReactOS/0.4.14/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set REACTOS_DIR "%DKTOOLS_DIR%\ReactOS"
	%dk_call% dk_set REACTOS_IMG %REACTOS_DIR%\reactos.img
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate QEMU_IMG_EXE "call %DKIMPORTS_DIR%\qemu\dk_installQemu.cmd"
	
	setlocal
		if exist "%REACTOS_IMG%" %return%
		
		%dk_call% dk_info "Installing ReactOS . . ."
		%dk_call% dk_basename %REACTOS_DL% REACTOS_DL_FILE
		%dk_call% dk_download %REACTOS_DL%
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%dk_call% dk_extract %DKDOWNLOAD_DIR%/%REACTOS_DL_FILE%
		
		:: create and cd into install directory
		%dk_call% dk_makeDirectory %REACTOS_DIR% 
		%dk_call% dk_cd %REACTOS_DIR%
		
		:::::: Install the OS to the .img file
		:: (Install from the running virtual OS)
		%dk_call% dk_info "########### ReactOS -install- ###############"
		%dk_call% dk_info " "
		%dk_call% dk_info ". Setup Instructions TODO here"
		
		:::::: Create the virtual image (10gb)
		%QEMU_IMG_EXE% create -f qcow2 %REACTOS_IMG% 10G

		:: Launching the VM
		%QEMU_SYSTEM_X86_64_EXE% -cdrom %DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso/ReactOS-0.4.14-release-119-gce0b4ff.iso -boot menu=on -drive file=%REACTOS_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
		
		:: create ReactOS Launcher
		%dk_call% dk_set REACTOS_launcher "%REACTOS_DIR%\LAUNCH.cmd"
		if exist "%REACTOS_launcher%" %return%	
		%dk_call% dk_fileWrite "%REACTOS_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=%REACTOS_IMG% -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installReactOS
%endfunction%
