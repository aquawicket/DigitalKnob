@echo off
call ..\..\..\DKBatch\functions\DK.cmd

:: https://reactos.org
:: https://reactos.org/wiki/QEMU

::####################################################################
::# dk_installReactOS()
::#
:dk_installReactOS
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set "REACTOS_DL=https://sourceforge.net/projects/reactos/files/ReactOS/0.4.14/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
	
	if not defined DKTOOLS_DIR call dk_setDKTOOLS_DIR
	call dk_set REACTOS "%DKTOOLS_DIR%\ReactOS"
	call dk_set REACTOS_IMG %REACTOS%\reactos.img
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate QEMU_IMG_EXE "call %DKIMPORTS_DIR%\qemu\dk_installQemu.cmd"
	
	setlocal
		if exist "%REACTOS_IMG%" goto:eof
		
		call dk_info "Installing ReactOS . . ."
		call dk_basename %REACTOS_DL% REACTOS_DL_FILE
		call dk_download %REACTOS_DL%
		call dk_extract %DKDOWNLOAD_DIR%/%REACTOS_DL_FILE%
		
		:: create and cd into install directory
		call dk_makeDirectory %REACTOS% 
		cd %REACTOS%
		
		:::::: Install the OS to the .img file
		:: (Install from the running virtual OS)
		call dk_info "########### ReactOS -install- ###############"
		call dk_info " "
		call dk_info ". Setup Instructions TODO here"
		
		:::::: Create the virtual image (10gb)
		%QEMU_IMG_EXE% create -f qcow2 %REACTOS_IMG% 10G

		:: Launching the VM
		%QEMU_SYSTEM_X86_64_EXE% -cdrom %DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso/ReactOS-0.4.14-release-119-gce0b4ff.iso -boot menu=on -drive file=%REACTOS_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
		
		:: create ReactOS Launcher
		call dk_set REACTOS_launcher "%REACTOS%\LAUNCH.cmd"
		if exist "%REACTOS_launcher%" goto:eof	
		call dk_fileWrite "%REACTOS_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=%REACTOS_IMG% -cpu max -smp 2 -vga virtio -display sdl"
	endlocal
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installReactOS
goto:eof
