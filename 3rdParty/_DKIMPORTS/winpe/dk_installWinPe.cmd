@echo off
call ..\..\..\DKBatch\functions\DK.cmd

::####################################################################
::# dk_installWinPE
::#
:dk_installWinPE
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"




    ::set "WINPE_DL=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuper%20Lite50MB.iso"
	set "WINPE_DL=https://ia802200.us.archive.org/22/items/windows-7-pesuper-lite-50-mb/Windows7PESuperLite50MB.iso"

    call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
    call dk_set WINPE "%DKTOOLS_DIR%\WindowsPE"
    call dk_set WINPE_IMG "%WINPE%\winpe.img"
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    call dk_validate QEMU_IMG_EXE "call %DKIMPORTS_DIR%\qemu\dk_installQemu.cmd"

    setlocal
        if exist "%WINPE_IMG%" call dk_info "%WINPE_IMG% already exists" && goto:eof
        
        call dk_info "Installing Windows PE . . ."
        call dk_basename %WINPE_DL% WINPE_DL_FILE
		echo %WINPE_DL_FILE% > %DIGITALKNOB_DIR%\dl_link.txt
        call dk_download "%WINPE_DL%"

        :: create and cd into install directory
        call dk_makeDirectory "%WINPE%" 
        cd "%WINPE%"

        :::::: Install the OS to the .img file
        :: (Install from the running virtual OS)
        call dk_info "########### Windows PE -install- ###############"
        call dk_info " "
        :: TODO
		
		:::::: Create the virtual image (10gb)
		%QEMU_IMG_EXE% create -f qcow2 %WINPE_IMG% 10G
		
		:: Launching the VM
		%QEMU_SYSTEM_X86_64_EXE% -cdrom "%DKDOWNLOAD_DIR%/%WINPE_DL_FILE%" -boot menu=on -drive file=%WINPE_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	
		:: create WINPE Launcher
		call dk_set WINPE_launcher "%WINPE%\LAUNCH.cmd"
		if exist "%WINPE_launcher%" call dk_info "%WINPE_launcher% already exists" &&goto:eof	
		call dk_fileWrite "%WINPE_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -boot menu=on -drive file=%WINPE_IMG% -cpu max -smp 2 -vga virtio -display sdl"
	
	endlocal
goto:eof
	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installWinPE
goto:eof