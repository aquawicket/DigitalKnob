@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	%dk_call% dk_getUrl %winpe_Import%
	set "WINPE_DL=%dk_getUrl%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set WINPE_DIR "%DKTOOLS_DIR%\WindowsPE"
	%dk_call% dk_set WINPE_IMG "%WINPE_DIR%\winpe.img"
	%dk_call% dk_set WINPE_QCOW "%WINPE_DIR%\winpe.qcow"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate QEMU_IMG_EXE "%dk_call% dk_depend qemu"

::	if NOT EXIST "%WINPE_QCOW%" (%QEMU_IMG_EXE% convert -O qcow2 "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" "%WINPE_QCOW%")
::	%QEMU_SYSTEM_X86_64_EXE% -drive file=%WINPE_QCOW% -m 1G -cpu max -smp 2 -vga virtio -display sdl
::	%return%
			
	::###### WINPE_IMG ######
    if EXIST "%WINPE_IMG%" (
		%dk_call% dk_info "%WINPE_IMG% already exists"
		goto end_WIN_IMG
	)
		%dk_call% dk_info "Installing Windows PE . . ."
		%dk_call% dk_basename %WINPE_DL% WINPE_IMPORT_FILE
		%dk_call% dk_download "%WINPE_DL%"

		::###### create and cd into install directory ######
		if NOT EXIST "%WINPE_DIR%" (%dk_call% dk_mkdir "%WINPE_DIR%")
		%dk_call% dk_chdir "%WINPE_DIR%"

		::###### Install the OS to the .img file ######
		:: (Install from the running virtual OS)
		:: %dk_call% dk_info "########### Windows PE -install- ###############"
		:: %dk_call% dk_info " "
		:: TODO

		::###### Create the virtual image (10gb) ######
		%QEMU_IMG_EXE% create -f qcow2 %WINPE_IMG% 5G
		
		::###### Launching the VM ######
		%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
		%QEMU_SYSTEM_X86_64_EXE% -cdrom "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" -drive file=%WINPE_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
			
		::%QEMU_SYSTEM_X86_64_EXE% -drive file=%WINPE_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl
	:end_WIN_IMG
		
	::###### WINPE_launcher ######
	set "WINPE_launcher=%WINPE_DIR%\LAUNCH.cmd"
	if EXIST "%WINPE_launcher%" (
		%dk_call% dk_info "%WINPE_launcher% already exists"
		%return%
	)
	::%dk_call% dk_fileWrite "%WINPE_launcher%" "start %QEMU_SYSTEM_X86_64_EXE% -cdrom "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" -boot menu=on -drive file=%WINPE_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl"
	%dk_call% dk_fileWrite "%WINPE_launcher%" -cdrom "%DKDOWNLOAD_DIR%/%WINPE_IMPORT_FILE%" "start %QEMU_SYSTEM_X86_64_EXE% -drive file=%WINPE_IMG% -m 1G -cpu max -smp 2 -vga virtio -display sdl"
%endfunction%
	



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%